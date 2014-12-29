class Auth::AccountsController < ApplicationController
  expose(:account) { AccountManager.new(params[:account_manager]) }

  def new; end

  def create
    if account.save
      redirect_to root_path,
        notice: "You're almost there. Now, you'll need to confirm your email"
    else
      render :new
    end
  end
end
