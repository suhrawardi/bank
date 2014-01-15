class TransfersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :only_allow_if_owned_by_current_user!

  def new
  end

  def create
  end
end
