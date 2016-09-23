module FreeDayInstanceHelper

  def self.start_date(date)
    beginning_of_month = CalendarHelper.prev_month_last_week_day(date)
    if beginning_of_month > Time.current
      beginning_of_month
    else
      Time.current
    end
  end

end