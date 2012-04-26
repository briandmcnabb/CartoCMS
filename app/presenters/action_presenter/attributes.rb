require 'active_support/concern'

module ActionPresenter
  module Attributes
    extend ActiveSupport::Concern

    module ClassMethods
      def attributes_for(view, attrs)
        instance_eval <<-RUBY
          def #{view}_attributes
            #{attrs}
          end
        RUBY
      end
    end
  end
end