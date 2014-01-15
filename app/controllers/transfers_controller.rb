class TransfersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :only_allow_if_owned_by_current_user!

  def new
  end

  def create
    destination = User.by_name(params[:name])
    Account::Transfer.new(current_user, destination).transfer(params[:amount])
    redirect_to user_accounts_path
  rescue
    flash[:alert] = $!.to_s
    redirect_to new_user_transfer_path
  end
end
