class EventInstancesController < BaseEventsController

  before_action :correct_user

  def index
    @events = if params[:user_id]
                EventInstance.occurrences(current_user, date_param)
              else
                EventInstance.occurrences(nil, date_param)
              end
  end

end
