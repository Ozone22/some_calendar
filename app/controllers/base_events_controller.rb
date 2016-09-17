class BaseEventsController < ApplicationController
  include EventViewHelper

  protected

  def correct_user
    if (user_id = params[:user_id])
      user = User.find_by(id: user_id)
      redirect_to user_events_path(current_user) unless current_user?(user)
    end
  end

end