module EventViewHelper

  def formatted_date(date)
    time_rule = '%Y-%m-%d'
    date.strftime(time_rule) if date
  end

end