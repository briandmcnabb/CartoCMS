module LayoutHelper

  # Nested Layouts Helper
  def parent_layout(layout)
    render :template => "layouts/#{layout}"
  end


  # Javascript Helpers
  def bodyscript(*args)
    content_for(:bodyscript) { javascript_include_tag(*args) }
  end

  def headscript(*args)
    content_for(:headscript) { javascript_include_tag(*args) }
  end

  def javascript(*args)
    content_for(:javascript) { javascript_include_tag(*args) }
  end


  # Stylesheet Helper
  def stylesheet(*args)
    content_for(:stylesheet) { stylesheet_link_tag(*args) }
  end

  # Title
  def title(site_name, options={})
    action  = options[:action]  || dynamic_title
    divider = options[:divider] || '::' if action
    [site_name, divider, action].join(' ')
  end

  private

  def dynamic_title
    case controller.action_name
    when 'index' then "#{resource_class.to_s.pluralize}"
    when 'show'  then "#{resource_class} #{resource.id}"
    when 'new'   then "#{controller.action_name.capitalize} #{resource_class}"
    when 'edit'  then "#{controller.action_name.capitalize} #{resource_class} #{resource.id}"
    end
  end
end
