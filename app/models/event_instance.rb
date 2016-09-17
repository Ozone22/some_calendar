class EventInstance
  include ActiveModel::AttributeMethods

  attr_accessor :name, :start_date, :event_id

  def initialize(name, start_date, event_id)
    self.name = name
    self.start_date = start_date
    self.event_id = event_id
  end

  def self.single_event_occurrences(event, end_date = nil)

    end_date ||= EventInstanceHelper.last_day_of_month

    event.schedule.occurrences(end_date).map do |date|
      event_instance = EventInstance.new(event.name, date, event.id)
      event_instance
    end

  end

  def self.occurrences(user = nil, end_date = nil)

    end_date = EventInstanceHelper.last_day_of_month(end_date)

    events = if user.nil?
               Event.where('start_date <= ?', end_date)
             else
               user.events.where('start_date <= ?', end_date)
             end

    events.map { |event|
      EventInstance.single_event_occurrences(event, end_date)
    }.flatten

  end

  def to_partial_path
    'event_instances/event_instance'
  end

end