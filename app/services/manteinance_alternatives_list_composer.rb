class ManteinanceAlternativesListComposer < BaseService

  attr_accessor :branches, :pauta

  def call
    self.pauta    = Pauta.includes(manteinance_items: :section_type).where(params).first
    return nil unless self.pauta
    self.branches = Branch.for_pauta(pauta)
    ManteinanceAlternativesList.new(pauta: pauta, branches: branches)
  end
end
