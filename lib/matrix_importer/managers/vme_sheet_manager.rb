module MatrixImporter
  module Managers
    class VmeSheetManager
      require 'roo'

      attr_accessor :vmes_ids

      def initialize(args = {})
        self.xlsx = args[:xlsx]
        self.vmes_ids = []
      end

      def verify_sheet_present!
        xlsx.sheet(Common::Constants::VMES_SHEET_NAME)

      rescue
        fail "Sheet #{Common::Constants::VMES_SHEET_NAME} doesn't exist"
      end

      def verify_all_vmes_present!
        xlsx.sheet(Common::Constants::VMES_SHEET_NAME).each_with_index do |row, i|
          next if i == 0
          self.vmes_ids << row[0].to_f
        end

        if vmes_ids.uniq.size < vmes_ids.size
          fail "There is duplicated vmes_ids on #{Common::Constants::VMES_SHEET_NAME} sheet"
        end

        if (db_vmes_ids = Vme.select(:vme_id).where(vme_id: vmes_ids).map(&:vme_id)).count < vmes_ids.size
          fail "Some vmes_ids aren't in database: (#{(vmes_ids - db_vmes_ids).join(', ')})"
        end
      end

      private

        attr_accessor :xlsx
    end
  end
end
