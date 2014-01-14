class AccountsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @account = user.account
  end

private

  def user
    User.find(params[:user_id])
  end
end
