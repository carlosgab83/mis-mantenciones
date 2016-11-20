class ManteinanceAlternativesListComposer < BaseService

  attr_accessor :branches, :pauta, :similar_pautas

  def call
    self.pauta = Pauta.includes(manteinance_items: :section_type).where(params).first
    return nil unless self.pauta
    self.branches = Branch.for_pauta(pauta)
    ManteinanceAlternativesList.new(pauta: pauta, branches: branches, similar_pautas: similar_pautas)
  end

  private

  def similar_pautas
    @similar_pautas ||= Pauta.where(vme_id: pauta.vme_id, kilometraje: pauta.kilometraje).where.not(id_pauta: pauta.id)
  end
end
