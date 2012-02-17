require 'will_paginate/view_helpers/action_view'
#require 'will_paginate/view_helpers/link_renderer'

module WillPaginate
  module ActionView
    def will_paginate(collection = nil, options = {})
      options, collection = collection, nil if collection.is_a? Hash

      collection ||= infer_collection_from_controller 
      options[:renderer] ||= BootstrapLinkRenderer
      super.try :html_safe
    end

    class BootstrapLinkRenderer < LinkRenderer
      def container_attributes
        super
        @container_attributes = @container_attributes.except(*([:remote]))
      end


      protected
      
      def html_container(html)
        tag :div, tag(:ul, html), container_attributes
      end

      def page_number(page)
        tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
      end

      def gap
        tag :li, link(super, '#'), :class => 'disabled'
      end

      def previous_or_next_page(page, text, classname)
        tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
      end
 

      private
      
      def link(text, target, attributes = {})
        attributes["data-remote"] = @options[:remote]
        super
      end
      
    end
  end
end