module EventsHelper

  def events_occurrences
    if params[:user_id]
      EventInstance.occurrences(current_user, date_param)
    else
      EventInstance.occurrences(nil, date_param)
    end
  end

  def date_param
    params[:start_date].to_time unless params[:start_date].nil?
  end

end