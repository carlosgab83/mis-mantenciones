# encoding: utf-8
class ManteinanceAlternativesList

  include ManteinanceAlternativesListSerializer
  attr_reader :pauta, :branches, :similar_pautas

  def initialize(args = {})
      self.pauta = args[:pauta]
      self.branches = args[:branches]
      self.similar_pautas = args[:similar_pautas]
  end

  private

  attr_writer :pauta, :branches, :similar_pautas
end
