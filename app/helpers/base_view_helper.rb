module BaseViewHelper

  def active_link_to(name = nil, options = nil, html_options = nil, &block)
    if current_page?(options)
      if html_options.nil?
        html_options = { class: 'active' }
      else
        html_options[:class] = "#{ html_options[:class] } active"
      end
    end
    link_to(name, options, html_options, &block)
  end

  def formatted_date(date)
    time_rule = '%Y-%m-%d'
    date.strftime(time_rule) if date
  end

  def array_format(array)
    array.each_with_index.map { |element, index| [element, index] }
  end

  def short_name(name)
    name.length > 20 ? name[0..19] : name
  end

end