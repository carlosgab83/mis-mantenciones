module BranchPlanManager
  class BranchPlan3 < Base

    def items
      other_promotions = Promotion.from("((#{promotions.to_sql}) union (#{generic_promotions.to_sql})) as promotions")
        .order("promotions.priority desc, promotions.promo_price asc, promotions.created_at desc")
        .limit(PROMOTIONS_LIMIT)

      {promotions: branch_information_relation + other_promotions + manteinances, products: branch_products}
    end

    private

    def promotions
      promotions = OtherPromotion.availables.actives.with_stock.not_deleted
        .joins(branches_promotions: :branch)
        .joins(promotions_vmes: {vme: {model: :brand}})
        .where("branches.id = ?", branch.id)

      if user_input.brand_id.present?
        promotions = promotions.where("marca.id_marca = ?", user_input.brand_id)
      end

      if user_input.model_id.present?
        promotions = promotions.where("modelo.id_modelo = ?", user_input.model_id)
      end

      promotions
    end

    def manteinances
      manteinances = Manteinance.none
      if not user_input.patent.present? and user_input.kms.present?
        return manteinances
      end

      vehicle = VehicleFinder.new(SearchVehicleForm.new('patent'=> user_input.patent)).call

      if vehicle.vme.present?
        manteinances = Manteinance.availables.actives.with_stock.not_deleted
          .joins(branches_promotions: :branch)
          .joins(:vmes)
          .where("branches.id = ?", branch.id)
          .where("vehiculo_modelo_especifico.vme_id = ?", vehicle.vme.vme_id)
      end

      if user_input.kms.present?
        manteinances = manteinances.where("promotions.kms IS NOT NULL")
        manteinances = manteinances.order("abs(promotions.kms - #{user_input.kms})")
      end

      manteinances
    end
  end
end
