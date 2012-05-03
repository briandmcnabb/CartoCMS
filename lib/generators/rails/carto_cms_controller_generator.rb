require 'rails/generators/resource_helpers'

module Rails
  module Generators
    class CartoCmsControllerGenerator < NamedBase
      include ResourceHelpers

      source_root File.expand_path("../templates", __FILE__)

      check_class_collision :suffix => "Controller"

      def create_controller_files
        template 'controller.rb', File.join('app/controllers', 'cms', class_path, "#{controller_file_name}_controller.rb")
      end
    end
  end
end
