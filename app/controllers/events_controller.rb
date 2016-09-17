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
    @event_instances = EventInstance.single_event_occurrences(@event) if @event.save
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
    @event_instances = EventInstance.single_event_occurrences(@event) if @event.update_attributes(event_params)
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
    params.require(:event).permit(:name, :start_date, :user_id, :repeat_type, :repeats_every_n_days)
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
