module NavbarHelper

  def dropdown_link(*args)
    options = args.extract_options!
    body    = args.first || show_current_in_list(options[:list], options[:current_page], default: options[:default])

    link_to '#', class: 'dropdown-toggle', data: { toggle: 'dropdown' } do
      out = ""
      out << content_tag(:span, body)
      out << content_tag(:b, '', class: 'caret')
      out.html_safe
    end
  end

  def menu_links(*args)
    options = args.extract_options!
    args.first.map {|item| menu_link(item, options)}.join.html_safe
  end

  def resource_dropdown_link
    dropdown_link current_page: resource_class.to_s.titleize.pluralize.downcase,
                       default: 'resources',
                          list: CartoCMS.resource_menu_items
  end


  private

  def menu_link(*args)
    options = args.extract_options!
    name    = args.first
    path    = send("cms_#{name}_path".to_sym)

    case options[:hide_current]
    when nil, true
      current = current_page?(path)
    else
      current = false
    end

    content_tag(:li, link_to(name.titleize, path)) unless current
  end



  def show_current_in_list(list, current_page, options={})
    if list.include? current_page
      current_page
    else
      options[:default]
    end
  end
end