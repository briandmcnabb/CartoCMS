module ActionPresenter
  class Base
    include Attributes

    def initialize(object, template)
      @object = object
      @template = template
    end


    class << self
      def self.inherited(subclass)
        name = subclass.to_s.gsub('Presenter', "").downcase.to_sym
        self.presents(name)
      end

      def self.presents(name)
        define_method(name) do
          @object
        end
      end
    end


    def method_missing(*args, &block)
      @template.send(*args, &block)
    end

    def handle_none(value, placeholder='Not Specified')   # Refactor 'placeholder' into a configuration initializer
      value.present? ? yield : placeholder
    end
  end
end