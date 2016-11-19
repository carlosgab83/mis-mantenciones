require 'matrix_importer/common/constants'

module MatrixImporter
  module Managers
    class BranchSheetManager
      require 'roo'

      attr_accessor :branches_ids, :branches_ids_with_variants_str, :variants_str

      def initialize(args = {})
        self.xlsx = args[:xlsx]
        self.branches_ids = []
        self.branches_ids_with_variants_str = []
        self.variants_str = {}
      end

      def verify_all_branches_present!
        branches do |name, branch_id, sheet, variants, variants_str|
          fail "On sheet #{name}, the variants on sheet name is missing or non compatible. e.g (6-011-taller)" if variants.nil?
          self.branches_ids << branch_id
          self.branches_ids_with_variants_str << "#{branch_id}-#{variants_str}"
          self.variants_str[branch_id] = [] if self.variants_str[branch_id].nil?
          self.variants_str[branch_id] << variants_str
        end

        if branches_ids_with_variants_str.uniq.size < branches_ids_with_variants_str.size
          fail "There is duplicated branchs_ids with variants"
        end

        if (db_branches_ids = Branch.select(:id).where(id: branches_ids).map(&:id)).uniq.count < branches_ids.uniq.size
          fail "Some branches_ids aren't in database: (#{(branches_ids - db_branches_ids.map{|b|b.to_s}).join(', ')})"
        end

        if self.variants_str[branches_ids.first].uniq.size < self.variants_str.values.flatten.uniq.size
          fail "Not all branches contain the same variants"
        end
      end

      def sheet(branch_id, variants_str)
        branches do |name, _branch_id, sheet, variants, _variants_str|
          return sheet if branch_id.to_s == _branch_id.to_s and variants_str == _variants_str
        end
        return nil
      end

      def branches
        xlsx.each_with_pagename do |name, sheet|
          next if name == Common::Constants::VMES_SHEET_NAME
          variants_str = name.split('-')[1]
          variants = Common::Constants::VME_VARIANTS[variants_str]
          branch_id = name.split('-').first
          yield(name, branch_id, sheet, variants, variants_str)
        end
      end

      def first_branch_with_variants
        first_branch_id = branches_ids.first
        branches do |name, branch_id, sheet, variants, variants_str|
          break if branch_id != first_branch_id
          yield(name, branch_id, sheet, variants, variants_str)
        end
      end

      def variants_by_branch(branch_id)
          variants = []
          branches do |name, _branch_id, sheet, _variants|
            next if branch_id != _branch_id
            variants << _variants
          end
          variants
        end

        def kms_by_branch_id(branch_id)
          branches do |name, _branch_id, sheet, variants|
            next if branch_id.to_s != _branch_id.to_s
            return kms_by_sheet(sheet).sort
          end
          return nil
        end

        def kms_by_sheet(sheet)
          return sheet.row(Common::Constants::TITLES_ROW)[Common::Constants::FIRST_KMS_INDEX..-1]
        end

      private

        attr_accessor :xlsx
    end
  end
end
