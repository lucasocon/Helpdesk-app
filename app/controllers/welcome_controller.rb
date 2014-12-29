class WelcomeController < ApplicationController

  expose(:title) { "Deliver exceptional customer service with Helpdesk — trusted by 30,000 companies worldwide." }

  def index
    if user_signed_in?
      redirect_to dashboard_path(current_user.joined_companies.first.slug)
    end
  end

end
