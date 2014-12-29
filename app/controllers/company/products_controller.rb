class Company::ProductsController < ApplicationController
  before_action :validates_ownership

  expose(:products_all) { current_company.products.most_recent }
  expose(:products) { current_company.products }
  expose(:product, attributes: :product_params)

  def index; end

  def new; end

  def create
    if current_user.products << product
      redirect_to root_path, notice: "Product created successfully"
    else
      render :new
    end
  end

protected
  def product_params
    params.require(:product).permit(:name, :description, :image)
  end
end
