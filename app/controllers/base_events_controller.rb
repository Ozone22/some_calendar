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
    month_date = if params[:current_page_date].nil?
                   params[:start_date]
                 else
                   params[:current_page_date]
                 end
    month_date.to_time unless month_date.nil?
  end

end