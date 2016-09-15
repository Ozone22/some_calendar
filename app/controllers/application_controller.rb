class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  include BaseViewHelper

  protected

  def signed_in_user
    unless signed_in?
      flash[:danger] = 'Please, sign in'
      redirect_to signin_path
    end
  end

  def unsigned_user
    if signed_in?
      redirect_to user_events_path(current_user)
    end
  end

  def correct_user
    user = User.find_by(id: params[:id])
    redirect_to user_events_path(current_user) unless current_user?(user)
  end

end
