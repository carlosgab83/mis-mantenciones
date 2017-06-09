# encoding: utf-8
class ManteinanceAlternativesList

  include ManteinanceAlternativesListSerializer
  attr_reader :pauta, :branches, :similar_pautas, :active_sorting_button

  def initialize(args = {})
      self.pauta = args[:pauta]
      self.branches = args[:branches]
      self.similar_pautas = args[:similar_pautas]
      self.active_sorting_button = args[:active_sorting_button]
  end

  private

  attr_writer :pauta, :branches, :similar_pautas, :active_sorting_button
end
