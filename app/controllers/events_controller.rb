class EventsController < ApplicationController

  before_action :signed_in_user
  before_action :correct_user, only: [:index, :new, :create]
  before_action :creator, only: [:edit, :update, :destroy]

  def index
    @events = if params[:user_id]
                current_user.events.all
              else
                Event.all
              end
    @events = @events.decorate
  end

  def new
    @event = Event.new.decorate
    respond_to do |format|
      format.js
    end
  end

  def create
    @event = current_user.events.build(event_params)
    @event = @event.decorate if @event.save
    respond_to do |format|
      format.js
    end
  end

  def edit
    @event = @event.decorate
    respond_to do |format|
      format.js
    end
  end

  def update
    @event = @event.decorate if @event.update_attributes(event_params)
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
    params.require(:event).permit(:name, :start_date)
  end

  def correct_user
    if (user_id = params[:user_id])
      user = User.find_by(id: user_id)
      redirect_to user_events_path(current_user) unless current_user?(user)
    end
  end

  def creator
    if (@event = Event.find_by(id: params[:id]))
      @event = @event.decorate
      render 'events/show' unless current_user?(@event.user)
    else
      redirect_to :back
    end
  end

end
