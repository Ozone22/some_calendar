class Event < ActiveRecord::Base

  extend SimpleCalendar

  belongs_to :user

  before_save { self.new_schedule }

  REPEATS_OPTIONS = %w(never daily weekly monthly yearly)
  DAYS_OF_THE_WEEK = %w(sunday monday tuesday wednesday thursday friday saturday)
  MONTHS_OF_THE_YEAR = %w(january february march april may june july august september october november december)

  attr_accessor :repeats_every_n_days
  attr_accessor :repeats_every_n_weeks
  attr_accessor :repeats_weekly_days_of_the_week
  attr_accessor :repeats_every_n_months

  validate :start_date_cannot_be_in_the_past
  validates :name, presence: true, length: { minimum: 2, maximum: 200 }
  validates :user_id, presence: true
  validates :start_date, presence: :true
  validates :repeat_type, presence: :true
  validates :repeats_every_n_days, presence: true,
            numericality: { greater_than: 0 }, if: Proc.new { |f| f.repeat_type.eql?('daily') }
  validates :repeats_every_n_weeks, presence: true,
            numericality: { greater_than: 0 }, if: Proc.new { |f| f.repeat_type.eql?('weekly') }
  validate :must_have_at_least_one_day_of_the_week, if: Proc.new { |f| f.repeat_type.eql?('weekly') }
  validates :repeats_every_n_months, presence: true,
            numericality: { greater_than: 0 }, if: Proc.new { |f| f.repeat_type.eql?('monthly') }

  serialize :schedule, IceCube::Schedule

  def new_schedule
    schedule = IceCube::Schedule.new(start_date)
    case repeat_type
      when 'daily'
        schedule.add_recurrence_rule IceCube::Rule.daily(repeats_every_n_days)
      when 'weekly'
        days = repeats_weekly_days_of_the_week.map { |day_number| day_number.to_i }
        schedule.add_recurrence_rule IceCube::Rule.weekly(repeats_every_n_weeks).day(days)
      when 'monthly'
        day = start_date.day
        schedule.add_recurrence_rule IceCube::Rule.monthly(repeats_every_n_months).day_of_month(day)
      else
        schedule.add_recurrence_time(start_date)
    end
    self.schedule = schedule
  end

  scope :events_by_time, -> (start_time, end_time) {
    where {
      (
        (repeat_type.eq 'never') &
        (start_date >= start_time) &
        (start_date <= end_time)
      ) | (
        (repeat_type.not_eq 'never') &
        (start_date <= end_time)
      )
    }
  }

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date <= DateTime.yesterday
      errors.add(:start_date, I18n.t('activerecord.errors.event.attributes.start_time.wrong_time'))
    end
  end

  def must_have_at_least_one_day_of_the_week
    if repeats_weekly_days_of_the_week.nil?
      errors.add(:base, I18n.t('activerecord.errors.event.attributes.repeats_every_n_weeks.days_not_exist'))
    end
  end

end
