module EventInstanceHelper

  # some additional days included (for calendar)

  def self.next_month_first_week_day(day = nil)
    end_month = if day.nil?
                  Date.today.end_of_month
                else
                  day.end_of_month
                end
    end_month + 6.days
  end

  def self.prev_month_last_week_day(day = nil)
    month_beginning = if day.nil?
                       Date.today.beginning_of_month
                     else
                       day.beginning_of_month
                     end
    month_beginning - 6.days
  end

end