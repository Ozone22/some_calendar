class EventInstancesController < BaseEventsController

  before_action :correct_user

  def index
    @events = if params[:users]
                user = User.find_by(id: params[:users])
                FreeDayInstance.free_days_between_users(current_user, user, date_param)
              else
                events_occurrences
              end
  end
end
