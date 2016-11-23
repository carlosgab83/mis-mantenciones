module ManteinanceCouponsHelper

  def similar_pautas_toggle_filters
    slim_markup = ''
    if show_traction
      slim_markup += <<-SLIM
        label.toggle-filter
          em Tracción
          input type="checkbox" name="toggle-filter-1"
          span Simple
          span 4 x 4
      SLIM
    end
    if show_engine
      slim_markup += <<-SLIM
        label.toggle-filter
          em Combustible
          input type="checkbox" name="toggle-filter-2"
          span Bencina
          span Diesel
      SLIM
    end
    if show_transmission
      slim_markup += <<-SLIM
        label.toggle-filter
          em Caja de cambios
          input type="checkbox" name="toggle-filter-3"
          span Mecánica
          span Automática
      SLIM
    end
    render_slim(slim_markup)
  end

  def show_engine
    @manteinance_alternatives_list.similar_pautas.map{|sp| sp.diesel_engine}.append(@manteinance_alternatives_list.pauta.diesel_engine).uniq.size > 1
  end

  def show_traction
    @manteinance_alternatives_list.similar_pautas.map{|sp| sp.double_traction}.append(@manteinance_alternatives_list.pauta.double_traction).uniq.size > 1
  end

  def show_transmission
    @manteinance_alternatives_list.similar_pautas.map{|sp| sp.automatic_transmission}.append(@manteinance_alternatives_list.pauta.automatic_transmission).uniq.size > 1
  end

  def branches
    pauta = @manteinance_alternatives_list.pauta
    slim_markup = <<-SLIM
      ul.list-unstyled
    SLIM
    @manteinance_alternatives_list.branches.each_with_index do |branch, i|
      slim_markup += <<-SLIM
          li class='#{"active" if i == 0}'
            a
              .lender
                span.name #{branch.name}
                span.location #{branch.comune.try(:name)}
              .prices
                span.normal #{number_to_currency(branch.full_price(pauta), precision: 0,  delimiter: '.')}
                span.special #{number_to_currency(branch.promo_price(pauta), precision: 0,  delimiter: '.')}
      SLIM
    end
    render_slim(slim_markup)
  end

  def branch_manteinance_items_for_first_listing_branch
    pauta = @manteinance_alternatives_list.pauta
    branch = @manteinance_alternatives_list.branches.first
    slim_markup = ''
    pauta.manteinance_items.each do |mi|
      slim_markup += <<-SLIM
        li class='#{"active" if branch.branches_manteinance_items_by_pauta(pauta).map{|bmi| bmi.manteinance_item_id}.include?(mi.id_item_mantencion)}' #{mi.desc_mantencion}
      SLIM
    end
    render_slim(slim_markup)
  end
end
