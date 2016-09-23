module EventsHelper

  def events_occurrences
    if params[:user_id]
      EventInstance.occurrences(current_user, date_param)
    else
      EventInstance.occurrences(nil, date_param)
    end
  end

end