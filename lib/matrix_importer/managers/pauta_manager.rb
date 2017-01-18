# encoding: utf-8
module MatrixImporter
  module Managers
    class PautaManager
      require 'roo'

      attr_accessor :vme_sheet_manager, :branch_sheet_manager, :manteinance_item_manager, :pautas

      def initialize(args = {})
        self.xlsx = args[:xlsx]
        self.vme_sheet_manager = args[:vme_sheet_manager]
        self.branch_sheet_manager = args[:branch_sheet_manager]
        self.manteinance_item_manager = args[:manteinance_item_manager]
        self.pautas = []
      end

      def create_or_update_generic_pauta
        branch_sheet_manager.first_branch_with_variants do |name, branch_id, sheet, variants, variants_str|
          xls_kms = branch_sheet_manager.kms_by_branch_id(branch_id)
          all_xls_variants = branch_sheet_manager.variants_by_branch(branch_id)
          Vme.includes(:model).where(vme_id: vme_sheet_manager.vmes_ids).each do |vme|
            db_pautas_kms = vme.pautas.where(variants).map{|pauta|pauta.kilometraje}.sort
            # Hay que validar si: en kms hay mas registros que en db, se deben agregar
            #                 si: en db hay registros que no estan en kms, se deben eliminar de db
            self.pautas += update_existing_pautas(vme, xls_kms, db_pautas_kms, branch_id, variants, variants_str)
            self.pautas += create_new_vme_pautas(vme, xls_kms, db_pautas_kms, branch_id, variants, variants_str)
            destroy_old_vme_pautas(vme, xls_kms, db_pautas_kms, all_xls_variants)
          end
        end
      end

      def create_or_update_each_branch_pauta
        branch_sheet_manager.branches do |name, branch_id, sheet, variants, variants_str|
          sheet = branch_sheet_manager.sheet(branch_id, variants_str)
          Pauta.where(id_pauta: pautas.map(&:id_pauta)).where(variants).each do |pauta|
            manteinance_items_array = manteinance_item_manager.manteinance_items_and_prices_by_km_by_sheet(pauta.kilometraje, sheet)
            manteinance_items_ids = manteinance_items_array.map{|h|h[:id]}
            db_items = BranchesManteinanceItem.where(pauta_id: pauta.id, branch_id: branch_id).to_a
            db_items_ids = db_items.map{|im| im.manteinance_item_id}
            create_branch_manteinance_items(manteinance_items_ids, db_items_ids, manteinance_items_array, db_items, pauta.id, branch_id)
            update_branch_manteinance_items(manteinance_items_ids, db_items_ids, manteinance_items_array, db_items, pauta.id, branch_id)
            destroy_branch_manteinance_items(manteinance_items_ids, db_items_ids, db_items, pauta.id, branch_id,manteinance_items_array)
          end
        end
      end

      def verify_uniq_and_same_kms_on_all_branches!
        all_kms = []
        branch_sheet_manager.branches do |name, branch_id, sheet, variants, variants_str|
          kms = branch_sheet_manager.kms_by_sheet(sheet)

          if kms.uniq.size < kms.size
            fail "Duplicated kms on branch #{name}"
          end
          all_kms << kms.sort
        end

        if all_kms.uniq.count > 1
          fail "List of kms differ between branches"
        end
      end

      private

      attr_accessor :xlsx

      def create_new_vme_pautas(vme, xls_kms, db_pautas_kms, branch_id, variants, variants_str)
        pautas_to_create  = []
        (xls_kms - db_pautas_kms).each do |km|
          pautas_to_create << Pauta.new({
            vme_id: vme.id,
            kilometraje: km,
            id_marca: vme.model.id_marca,
            id_modelo: vme.model.id,
            pauta_descripcion: "Mantención"
            }.merge(variants)
          )
        end
        columns = [:pauta_descripcion, :kilometraje, :id_marca, :id_modelo, :vme_id] + variants.keys
        Pauta.import(columns, pautas_to_create)
        pautas_to_create.each do |pauta|
          sheet = branch_sheet_manager.sheet(branch_id, variants_str)
          new_manteinance_items = manteinance_item_manager.manteinance_items_and_prices_by_km_by_sheet(pauta.kilometraje, sheet).map{|h| h[:obj]}
          update_manteinance_items(pauta, pauta.manteinance_items, new_manteinance_items)
        end
        pautas_to_create
      end

      def update_existing_pautas(vme, xls_kms, db_pautas_kms, branch_id, variants, variants_str)
        (pautas_to_update = Pauta.where(vme_id: vme.id, kilometraje: (xls_kms & db_pautas_kms)).where(variants)).each do |pauta|
          sheet = branch_sheet_manager.sheet(branch_id, variants_str)
          new_manteinance_items = manteinance_item_manager.manteinance_items_and_prices_by_km_by_sheet(pauta.kilometraje, sheet).map{|h| h[:obj]}
          pauta.manteinance_items.delete(pauta.manteinance_items - new_manteinance_items)
          pauta.manteinance_items << (new_manteinance_items - pauta.manteinance_items)
        end
        pautas_to_update
      end

     def destroy_old_vme_pautas(vme, xls_kms, db_pautas_kms, all_xls_variants)
        pauta_ids = Pauta.where(vme_id: vme.id, kilometraje: (db_pautas_kms - xls_kms)).pluck(:id_pauta)
        PautaDetail.unscoped.where(id_pauta: pauta_ids).delete_all
        BranchesManteinanceItem.unscoped.where(pauta_id: pauta_ids).delete_all
        Pauta.where(id_pauta: pauta_ids).delete_all
        pg_values = []
        all_xls_variants.each do |variant|
          pg_values << "'" + variant.values.map{|v|v.to_s[0]}.join + "'"
        end

        pauta_ids = Pauta.where(vme_id: vme.id).where("concat(#{all_xls_variants.first.keys.join(',')}) not in (#{pg_values.join(',')})")
        PautaDetail.unscoped.where(id_pauta: pauta_ids).delete_all
        BranchesManteinanceItem.unscoped.where(pauta_id: pauta_ids).delete_all
        Pauta.unscoped.where(id_pauta: pauta_ids).delete_all
      end

      def create_branch_manteinance_items(manteinance_items_ids, db_items_ids, manteinance_items_array, db_items, pauta_id, branch_id)
        branches_items = []
        (manteinance_items_ids - db_items_ids).each do |id|
          manteinance_item = manteinance_items_array.select{|h| h[:id] == id}.first
          branches_items << BranchesManteinanceItem.new(
            manteinance_item_id: id,
            branch_id: branch_id,
            pauta_id: pauta_id,
            full_price: manteinance_item[:full_price],
            discount_percentage: manteinance_item[:discount_percentage],
            promo_price: manteinance_item[:promo_price]
          )
        end
        BranchesManteinanceItem.import(branches_items)
      end

      def update_branch_manteinance_items(manteinance_items_ids, db_items_ids, manteinance_items_array, db_items, pauta_id, branch_id)
        db_items.select{|bmi| manteinance_items_array.map{|mi| mi[:id]}.include?(bmi.manteinance_item_id)}.each do |branch_item|
          xls_manteinance_item = manteinance_items_array.select{|mi| branch_item.manteinance_item_id == mi[:id]}.first
          branch_item.full_price = xls_manteinance_item[:full_price]
          branch_item.discount_percentage = xls_manteinance_item[:discount_percentage]
          branch_item.promo_price = xls_manteinance_item[:promo_price]
          branch_item.save if branch_item.changed?
        end
      end

      def destroy_branch_manteinance_items(manteinance_items_ids, db_items_ids, db_items, pauta_id, branch_id,manteinance_items_array)
        ids_to_destroy = (db_items_ids - manteinance_items_ids)
        db_items.select{|bmi| ids_to_destroy.include?(bmi.manteinance_item_id)}.each do |branch_item|
          branch_item.delete
        end
      end

      def update_manteinance_items(pauta, old_manteinance_items, new_manteinance_items)
        pauta.manteinance_items.destroy(old_manteinance_items - new_manteinance_items)
        pauta.manteinance_items << (new_manteinance_items - old_manteinance_items)
      end
    end
  end
end
