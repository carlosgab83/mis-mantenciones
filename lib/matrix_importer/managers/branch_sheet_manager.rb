module MatrixImporter
  module Managers
    class BranchSheetManager
      require 'roo'

      attr_accessor :branches_ids

      def initialize(args = {})
        self.xlsx = args[:xlsx]
        self.branches_ids = []
      end

      def verify_all_branches_present!
        branches do |name, branch_id, sheet|
          self.branches_ids << branch_id
        end

        if branches_ids.uniq.size < branches_ids.size
          fail "There is duplicated branchs_ids"
        end

        if (db_branches_ids = Branch.select(:id).where(id: branches_ids).map(&:id)).count < branches_ids.size
          fail "Some branches_ids aren't in database: (#{(branches_ids - db_branches_ids.map{|b|b.to_s}).join(', ')})"
        end
      end

      def sheet(branch_id)
        branches do |name, _branch_id, sheet|
          return sheet if branch_id.to_s == _branch_id.to_s
        end
        return nil
      end

      def branches
        xlsx.each_with_pagename do |name, sheet|
          next if name == Common::Constants::VMES_SHEET_NAME
          branch_id = name.split('-').first
          yield(name, branch_id, sheet)
        end
      end

      private

        attr_accessor :xlsx
    end
  end
end
