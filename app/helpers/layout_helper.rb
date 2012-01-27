module LayoutHelper
  
  # Nested Layouts Helper  
  def parent_layout(layout)
    render :template => "layouts/#{layout}"
  end
  
  
  # Set title
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end


  # Stylesheet Helper
  def stylesheet(*args)
    content_for(:stylesheet) { stylesheet_link_tag(*args) }
  end


  # Javascript Helpers
  def headscript(*args)
    content_for(:headscript) { javascript_include_tag(*args) }
  end
  
  def bodyscript(*args)
    content_for(:bodyscript) { javascript_include_tag(*args) }
  end
end
