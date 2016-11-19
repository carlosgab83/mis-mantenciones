module MatrixImporter
  module Managers
    class ManteinanceItemManager
      require 'roo'

      attr_accessor :xlsx, :manteinance_items_ids, :manteinance_items

      def initialize(args = {})
        self.xlsx = args[:xlsx]
      end

      def verify_all_manteinance_items_presents!
        all_manteinance_items_ids = []
        page_count = 0
        first_name = nil
        xlsx.each_with_pagename do |name, sheet|
          next if name == Common::Constants::VMES_SHEET_NAME
          first_name ||= name
          page_count +=1
          manteinance_items_rows = []
          manteinance_items_ids = []
          sheet.each_with_index do |row, i|
            next if i == 0
            break if row[0].nil?
            manteinance_items_ids << row[0]
            manteinance_items_rows << row[2..-1]
          end

          verify_all_manteinance_items_with_at_least_one_price!(manteinance_items_rows, name) if first_name.split('-').first == name.split('-').first

          self.manteinance_items = ManteinanceItem.where(id_item_mantencion: manteinance_items_ids).to_a
          db_manteinance_items_ids = manteinance_items.pluck(:id_item_mantencion).uniq

          if db_manteinance_items_ids.uniq.count < manteinance_items_ids.uniq.count
            fail "On branch #{name}, some manteinance_items_ids aren't in database: #{(manteinance_items_ids.uniq - db_manteinance_items_ids.uniq).join(', ')}"
          end
          all_manteinance_items_ids << {name: name, manteinance_items_ids: manteinance_items_ids.sort}
        end

        # Check for duplicates on first branch
        first_manteinance_items_ids = all_manteinance_items_ids[0]
        if first_manteinance_items_ids[:manteinance_items_ids].uniq.count < first_manteinance_items_ids[:manteinance_items_ids].count
          fail "There is duplicated manteinance items on first branch: #{first_manteinance_items_ids[:name]}"
        end

        # Check all manteinance_items between branches is the same
        all_manteinance_items_ids[1..-1].each do |each_branch|
          if [[first_manteinance_items_ids[:manteinance_items_ids].sort.uniq], [each_branch[:manteinance_items_ids]].sort.uniq].uniq.count > 1
            fail "On branch #{each_branch[:name]}, list of manteinance_items differ with first branch"
          end
        end

        self.manteinance_items_ids = manteinance_items_ids
      end

      def manteinance_items_and_prices_by_km_by_sheet(km, sheet)
        km_index = -1
        discount_percentage = 0
        manteinance_items_array = []
        sheet.each_with_index do |row, i|
          if i == 0
            km_index = row.index(km)
            next
          end
          manteinance_items_array << {id: row[0].to_i, full_price: row[km_index].to_f.round(2)} if row[km_index].present? and row[0].present?
          if row[0].blank? # Estoy en la fila del porcentaje de descuento
            discount_percentage = row[km_index].to_f.round(2)
            break
          end
        end
        manteinance_items_array.collect do |hash|
          hash[:obj] = self.manteinance_items.select{|mi| mi.id == hash[:id]}.first
          hash[:discount_percentage] = discount_percentage
          hash[:promo_price] = (hash[:full_price] *  (1 - discount_percentage)).round(2)
        end
        return manteinance_items_array
      end

      private

      def verify_all_manteinance_items_with_at_least_one_price!(manteinance_items_rows, branch)
        manteinance_items_rows.each do |row|
          if row.compact.empty?
            fail "There is some manteinance_items without price on branch #{branch}"
          end
        end
      end
    end
  end
end
