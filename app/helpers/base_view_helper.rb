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

end