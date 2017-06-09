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
      promotions_or_manteinances_by_vehicle(OtherPromotion)
    end

    def manteinances
      promotions_or_manteinances_by_vehicle(Manteinance)
    end

    def promotions_or_manteinances_by_vehicle(promotion_type_class)
      _result_relation = promotion_type_class.availables.actives.with_stock.not_deleted
        .joins(branches_promotions: :branch)
        .joins(promotions_vmes: {vme: {model: :brand}})
        .where("branches.id = ?", branch.id)

      if user_input.brand_id.present?
        _result_relation = _result_relation.where("marca.id_marca = ?", user_input.brand_id)
      end

      if user_input.model_id.present?
        _result_relation = _result_relation.where("modelo.id_modelo = ?", user_input.model_id)
      end

      if user_input.patent.present?
        vehicle = VehicleFinder.new(SearchVehicleForm.new('patent'=> user_input.patent)).call

        if vehicle.vme.present?
          _result_relation = _result_relation.where("vehiculo_modelo_especifico.vme_id = ?", vehicle.vme.vme_id)
        end

        if user_input.kms.present?
          _result_relation = _result_relation.where("promotions.kms IS NOT NULL")
          _result_relation = _result_relation.order("abs(promotions.kms - #{user_input.kms})")
        end
      end

      _result_relation
    end

  end
end
