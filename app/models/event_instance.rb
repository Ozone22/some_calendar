class EventInstance
  include ActiveModel::AttributeMethods

  attr_accessor :name, :start_date, :event_id

  def initialize(name, start_date, event_id)
    self.name = name
    self.start_date = start_date
    self.event_id = event_id
  end

  def self.single_event_occurrences(event, month_date = nil, get_next_month_week = true)

    if month_date.nil? || get_next_month_week
      month_date = EventInstanceHelper.next_month_first_week_day(month_date)
    end

    event.schedule.occurrences(month_date).map do |date|
      event_instance = EventInstance.new(event.name, date, event.id)
      event_instance
    end

  end

  def self.occurrences(user = nil, end_date = nil)

    end_date = EventInstanceHelper.next_month_first_week_day(end_date)

    events = if user.nil?
               Event.where('start_date <= ?', end_date)
             else
               user.events.where('start_date <= ?', end_date)
             end

    events.map { |event|
      EventInstance.single_event_occurrences(event, end_date, false)
    }.flatten

  end

  def to_partial_path
    'event_instances/event_instance'
  end

end