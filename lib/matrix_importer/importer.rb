module MatrixImporter
  class Importer
    require 'roo'

    attr_accessor :file

    RECORDS_AT_ONCE = 500

    def initialize(args = {})
      self.file = args[:file]
    end

    def import(file = self.file)
      self.file = file
      ensure_params!
      open_file
      initialize_managers
      validate_vmes!
      validate_branches!
      validate_kms!
      validate_manteinance_items!

      ActiveRecord::Base.transaction do
        proccess_all_file
      end

    rescue Exception => e
      puts e.message
      puts e.backtrace
      fail e.message
    end

    private

    attr_accessor :xlsx, :vme_sheet_manager, :branch_sheet_manager, :manteinance_item_manager, :pauta_manager

    def proccess_all_file
      pauta_manager.create_or_update_generic_pauta
      pauta_manager.create_or_update_each_branch_pauta
    end

    def validate_manteinance_items!
      manteinance_item_manager.verify_all_manteinance_items_presents!
    end

    def validate_kms!
      pauta_manager.verify_uniq_and_same_kms_on_all_branches!
    end

    def validate_branches!
      branch_sheet_manager.verify_all_branches_present!
    end

    def validate_vmes!
      vme_sheet_manager.verify_sheet_present!
      vme_sheet_manager.verify_all_vmes_present!
    end

    def initialize_managers
      self.vme_sheet_manager = Managers::VmeSheetManager.new(xlsx: xlsx)
      self.branch_sheet_manager = Managers::BranchSheetManager.new(xlsx: xlsx)
      self.manteinance_item_manager = Managers::ManteinanceItemManager.new(xlsx: xlsx)
      self.pauta_manager = Managers::PautaManager.new(
        xlsx: xlsx,
        vme_sheet_manager: vme_sheet_manager,
        branch_sheet_manager: branch_sheet_manager,
        manteinance_item_manager: manteinance_item_manager
      )
    end

    def open_file
      self.xlsx = Roo::Spreadsheet.open(file)
    end

    def ensure_params!
      fail 'Filename not specified' if file.nil?
    end
  end
end
