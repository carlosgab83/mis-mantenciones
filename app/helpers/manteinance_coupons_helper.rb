module ManteinanceCouponsHelper

  def show_engine
    @manteinance_alternatives_list.similar_pautas.map{|sp| sp.diesel_engine}.append(@manteinance_alternatives_list.pauta.diesel_engine).uniq.size > 1
  end

  def show_traction
    @manteinance_alternatives_list.similar_pautas.map{|sp| sp.double_traction}.append(@manteinance_alternatives_list.pauta.double_traction).uniq.size > 1
  end

  def show_transmission
    @manteinance_alternatives_list.similar_pautas.map{|sp| sp.automatic_transmission}.append(@manteinance_alternatives_list.pauta.automatic_transmission).uniq.size > 1
  end
end
