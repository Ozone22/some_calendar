class EventDecorator < Draper::Decorator
  delegate_all

  def get_date
    time_rule = '%Y-%m-%d'
    start_date.strftime(time_rule) if object.start_date
  end

  def in_current_month?
    time_rule = '%Y-%m'
    start_date.strftime(time_rule) == Time.now.strftime(time_rule)
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
