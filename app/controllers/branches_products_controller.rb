class BranchesProductsController < ApplicationController
  protect_from_forgery with: :exception

  def open_url
    @branches_product = BranchesProduct.where(id: params[:id]).first
    if (url = @branches_product.try(:url))
      EventTracker::OpenBranchesProductUrl.new(controller: self, vehicle: session[:vehicle], client: session[:client],
        product: @branches_product.product, branch: @branches_product.branch, url: @branches_product.url).track
      redirect_to url
    end
  end
end
