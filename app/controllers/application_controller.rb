class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :def_layout

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  expose(:current_company) { Company.friendly.find(params[:company_slug]) }

protected

  def def_layout
    user_signed_in? ? "application" : "logged"
  end
  def render_404
    render(file: "#{Rails.root}/public/404",
      formats: :html, layout: false, status: 404)
  end

  def validates_ownership
    unless current_company.owned_by(current_user.id)
      redirect_to root_path
    end
  end
end
