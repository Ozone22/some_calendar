module EventInstanceHelper

  # some additional days included (for calendar)

  def self.last_day_of_month(day = nil)
    if day.nil?
      (Date.today.end_of_month + 6).to_time
    else
      (day.end_of_month + 6).to_time
    end
  end

end