class EventsController < BaseEventsController

  before_action :signed_in_user
  before_action :correct_user, only: [:new, :create]
  before_action :creator, only: [:edit, :update, :destroy]

  def new
    @event = Event.new.decorate
    respond_to do |format|
      format.js
    end
  end

  def create
    @event = current_user.events.build(event_params).decorate
    @event_instances = if @event.save
                         EventInstance.single_event_occurrences(@event, end_date: date_param)
                       end
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @event_instances = if @event.update_attributes(event_params)
                         EventInstance.single_event_occurrences(@event, end_date: date_param)
                       end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_date, :repeat_type, :repeats_every_n_days,
                                  :repeats_every_n_weeks, :repeats_every_n_months,
                                  :repeats_weekly_days_of_the_week => [])
  end

  def creator
    if (@event = Event.find_by(id: params[:id]))
      @event = @event.decorate
      render 'events/show' unless current_user?(@event.user)
    else
      redirect_to user_events_path
    end
  end

end
