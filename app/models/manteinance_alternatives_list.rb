# encoding: utf-8
class ManteinanceAlternativesList

  include ManteinanceAlternativesListSerializer
  attr_reader :pauta, :branches

  def initialize(args = {})
      self.pauta = args[:pauta]
      self.branches = args[:branches]
  end

  private

  attr_writer :pauta, :branches
end
