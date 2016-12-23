class ManteinanceAlternativesListComposer < BaseService

  attr_accessor :branches, :pauta, :similar_pautas, :active_sorting_button

  def call
    Rails.cache.fetch("#alternatives_list_#{params.values.join('_')}", expires_in: 2.minutes) do
      self.pauta = Pauta.includes(manteinance_items: :section_type).where(params).first
      return nil unless self.pauta
      self.branches = Branch.for_pauta(pauta)
      ManteinanceAlternativesList.new(pauta: pauta, branches: branches, similar_pautas: similar_pautas, active_sorting_button: active_sorting_button)
    end
  end

  private

  def similar_pautas
    @similar_pautas ||= Pauta.where(vme_id: pauta.vme_id, kilometraje: pauta.kilometraje).where.not(id_pauta: pauta.id)
  end
end
