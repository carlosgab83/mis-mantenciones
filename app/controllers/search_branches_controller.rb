class SearchBranchesController < ApplicationController
  include ModelSelector

  # Make new search based on user criteria
  def create
    session[:search_branches_params] = params[:search]
    search_branches

    EventTracker::ClickSearchBranches.new(
      controller: self,
      client: session[:client],
      search_branches_form: search_branches_form,
      found_branches: @branches.count
    ).track

    respond_to do |format|
      format.js
    end
  end

  def show
    params[:search] = session[:search_branches_params]
    @branch_items = BranchItemsFinder.new(branch: branch, form: search_branches_form).call

    EventTracker::ClickBranch.new(
      controller: self,
      client: session[:client],
      branch: branch,
      search_branches_form: search_branches_form
    ).track

    respond_to do |format|
      format.js
      format.html {search_branches}
    end
  end

  private

  def search_branches
    @branches ||= BranchesFinder.new(form: search_branches_form).call
  end

  def search_branches_form
    @search_branches_form ||= SearchBranchesForm.new(params[:search]  || {})
  end

  def branch
    @branch ||= Branch.includes(:branch_type).friendly.find(params[:id])
  end
end
