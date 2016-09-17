class EventDecorator < Draper::Decorator
  delegate_all

  def in_current_month?
    time_rule = '%Y-%m'
    start_date.strftime(time_rule) == Time.now.strftime(time_rule)
  end

end
