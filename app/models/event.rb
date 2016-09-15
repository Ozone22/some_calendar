class Event < ActiveRecord::Base

  extend SimpleCalendar

  belongs_to :user

  validate :start_date_cannot_be_in_the_past
  validates :name, presence: true, length: { minimum: 2, maximum: 200 }
  validates :user_id, presence: true
  validates :start_date, presence: :true

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date <= DateTime.yesterday
      errors.add(:start_date, I18n.t('activerecord.errors.event.attributes.start_time.wrong_time'))
    end
  end

end
