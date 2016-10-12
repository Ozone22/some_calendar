class BaseEventsController < ApplicationController
  include EventsHelper

  protected

  def correct_user
    if (user_id = params[:user_id])
      user = User.find_by(id: user_id)
      redirect_to signin_path unless current_user?(user)
    end
  end

  def date_param
    params[:start_date].to_time unless params[:start_date].nil?
  end

end