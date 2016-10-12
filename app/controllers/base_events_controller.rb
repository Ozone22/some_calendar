class BaseEventsController < ApplicationController
  include EventsHelper

  protected

  def correct_user
    if (user_id = params[:user_id])
      user = User.find_by(id: user_id)
      redirect_to signin_path unless current_user?(user)
    end
  end

end