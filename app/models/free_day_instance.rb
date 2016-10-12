class FreeDayInstance
  include ActiveModel::AttributeMethods
  include FreeDayInstanceHelper

  attr_accessor :start_date

  def initialize(start_date)
    self.start_date = start_date
  end

  def self.free_days_between_users(user1, user2, end_date = nil)

    start_date = FreeDayInstanceHelper.start_date(end_date)
    next_month = CalendarHelper.next_month_first_week_day(end_date)

    month_days_array = CalendarHelper.array_of_month_days(start_date: start_date, end_date: next_month)

    event_days = [user1, user2].map do |user|
      EventInstance.occurrences(user, end_date, &self.event_dates_block).map do |occurrence_date|
        occurrence_date.strftime('%Y-%m-%d')
      end
    end

    event_days.flatten!
    free_days = month_days_array - event_days
    free_days.map { |free_day| FreeDayInstance.new(free_day.to_datetime) }
  end

  def to_partial_path
    'free_day_instances/free_day_instance'
  end

  private

  def self.event_dates_block
    Proc.new { |event, start_date, end_date| event.schedule.occurrences_between(start_date, end_date) }
  end

end