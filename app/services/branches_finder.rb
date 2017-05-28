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
    branches = branches.where("marca.id_marca = ?", user_input.brand_id) if user_input.brand_id
  end

  def advanced_search(branches)
    vehicle = VehicleFinder.new(SearchVehicleForm.new('patent'=> user_input.patent)).call
    if vehicle.vme.present?
      branches = branches.joins(promotions: :vmes).where("vehiculo_modelo_especifico.vme_id = ?", vehicle.vme.vme_id)
    else
      # What to do here?
      branches
    end
  end

  def user_input
    @user_input ||= params[:form]
  end
end
