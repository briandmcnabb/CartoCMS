module Rails
  module Generators
    class Page < NamedBase
      desc "Generate static page templates"
      source_root File.expand_path("../templates", __FILE__)
      class_option :standalone, :type => :boolean, :default => false, :desc => "Page won't use application layout"
    
      def add_template
        template "_page.html.haml", "app/views/pages/_#{name}.html.haml"
      end
      
      def add_stylesheet
        template "stylesheet.css.scss", "app/assets/stylesheets/pages/#{name}.css.scss"
      end
         
      def add_javascript
        copy_file "javascript.js.coffee", "app/assets/javascripts/pages/#{name}.js.coffee"
      end
    end
  end
end