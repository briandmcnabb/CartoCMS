module Rails
  module Generators
    class Presenter < NamedBase
      desc "Generate a presenter to present your object."
      
      source_root File.expand_path("../templates", __FILE__)
      
      argument :attributes, :type => :array, :default => [], :banner => "field[:type][:index] field[:type][:index]"
      
      
      def add_presenter
        template "presenter.rb", "app/presenters/#{name}_presenter.rb"
      end
    end
  end
end