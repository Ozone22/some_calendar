module EventsHelper

  def formatted_date(date)
    time_rule = '%Y-%m-%d'
    date.strftime(time_rule) if date
  end

  def array_format(array)
    array.each_with_index.map { |element, index| [element, index] }
  end

end