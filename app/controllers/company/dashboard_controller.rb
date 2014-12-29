class Company::DashboardController < ApplicationController
  expose(:company) {
    current_user.joined_companies.friendly.find(params[:company_slug])
  }

  expose(:products)     { current_company.products.latest }
  expose(:products_all) { current_company.products.most_recent }

  def index; end

  def all_products; end
end
