module CalendarHelper

  # some additional days included (for calendar)

  def self.next_month_first_week_day(day = nil)
    end_month = if day.nil?
                  Date.today.end_of_month
                else
                  day = day.to_time
                  day.end_of_month
                end
    end_month + 6.days
  end

  def self.prev_month_last_week_day(day = nil)
    month_beginning = if day.nil?
                       Date.today.beginning_of_month
                      else
                        day = day.to_time
                        day.beginning_of_month
                     end
    month_beginning - 6.days
  end

  def self.array_of_month_days(start_date: nil, end_date: nil)
    start_date = Date.today.beginning_of_month if start_date.nil?
    end_date = Date.today.end_of_month if end_date.nil?
    (start_date.to_date..end_date.to_date).map { |date| date.strftime('%Y-%m-%d') }
  end

end