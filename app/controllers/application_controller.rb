class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def only_allow_if_owned_by_current_user!
    return if current_user.id == params[:user_id].to_i
    redirect_to new_user_session_path
  end
end
