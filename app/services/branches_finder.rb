class BranchesFinder < BaseService

  def call
    branches = Branch.includes(:branch_type).actives.with_plan
    if user_input.empty_search?
      branches
    elsif user_input.basic_search?
      basic_search(branches)
    else
      advanced_search(branches)
    end
  end

  private

  def basic_search(branches)
    branches = branches.joins(promotions: {vmes: {model: :brand}})
    branches = branches.where("modelo.id_modelo = ?", user_input.model_id) if user_input.model_id
    branches.where("marca.id_marca = ?", user_input.brand_id) if user_input.brand_id
    Branch.from("(#{branches.to_sql} union #{branches_with_generic_promotions.to_sql}) as branches").uniq
  end

  def advanced_search(branches)
    vehicle = VehicleFinder.new(SearchVehicleForm.new('patent'=> user_input.patent)).call

    if vehicle.vme.present?
      branches1 = branches
                  .joins(promotions: :vmes)
                  .joins(:plan)
                  .where("vehiculo_modelo_especifico.vme_id = ?", vehicle.vme.vme_id)
                  .where("promotions.type in ('#{OtherPromotion}', '#{BranchInformation}', '#{Manteinance}')")
                  .where("plans.name not in ('#{Plan::PLAN1}')")

      branches2 = Branch.where('1<>1')
      if user_input.kms.present?
        branches2 = branches
                      .joins(promotions: :vmes)
                      .joins(:plan)
                      .where("vehiculo_modelo_especifico.vme_id = ?", vehicle.vme.vme_id)
                      .where("promotions.kms IS NOT NULL and promotions.type in ('#{Manteinance}')")
                      .where("plans.name not in ('#{Plan::PLAN1}', '#{Plan::PLAN2}')")
      end

      Branch.from("(#{branches1.to_sql} union #{branches2.to_sql} union #{branches_with_generic_promotions.to_sql}) as branches").uniq
    else
      # What to do here?
      branches
    end
  end

  def branches_with_generic_promotions
    Branch.includes(:branch_type).actives.with_plan.where("
      branches.id not in
        (
          select bp.branch_id
          from branches_promotions bp
          where bp.deleted = false
          and bp.promotion_id not in (
            select pv.promotion_id
            from promotions_vmes pv
            where deleted = false
          )
        )
    ")
  end

  def user_input
    @user_input ||= params[:form]
  end
end
