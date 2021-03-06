module LayoutHelper
  # Flash Messages
  def flash_messages
    out = ''
    flash.each do |name, msg|
      out << content_tag(:aside, msg, class: 'flash_message', id: "flash_#{name}")
    end
    flash.clear
    out.html_safe
  end


  # Index Partial Selector
  def index_partial
    position ? 'index-list' : "index-table"
  end


  # Nested Layouts Helper
  def parent_layout(layout)
    render template: "layouts/#{layout}"
  end


  # Javascript Helpers
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
end


