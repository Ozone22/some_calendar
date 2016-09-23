class EventInstance
  include ActiveModel::AttributeMethods

  attr_accessor :name, :start_date, :event_id

  def initialize(name, start_date, event_id)
    self.name = name
    self.start_date = start_date
    self.event_id = event_id
  end

  def self.single_event_occurrences(event, start_date: nil, end_date: nil, calculate_dates: true)

    if calculate_dates || (start_date.nil? || end_date.nil?)
      end_date = CalendarHelper.next_month_first_week_day(end_date)
      start_date = CalendarHelper.prev_month_last_week_day(start_date)
    end

    event.schedule.occurrences_between(start_date, end_date).map do |date|
      event_instance = EventInstance.new(event.name, date, event.id)
      event_instance
    end

  end

  def self.occurrences(user = nil, end_date = nil, &block)

    start_date = CalendarHelper.prev_month_last_week_day(end_date)
    end_date = CalendarHelper.next_month_first_week_day(end_date)

    events = if user.nil?
               Event.by_time(start_date, end_date)
             else
               user.events.by_time(start_date, end_date)
             end

    occurrence_args = { start_date: start_date, end_date: end_date, calculate_dates: false }

    occurrences = events.map do |event|
      if block_given?
        block.call(event, start_date, end_date)
      else
        self.single_event_occurrences(event, occurrence_args)
      end
    end

    occurrences.flatten

  end

  def to_partial_path
    'event_instances/event_instance'
  end

end