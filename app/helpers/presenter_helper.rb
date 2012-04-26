module PresenterHelper

  def present(object, klass = nil)
    klass ||= presentify(object)
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def method_missing(method_name, *arguments, &block)
    if method_name.to_s =~ /^(\w+)_attributes$/
      define_dynamic_attribute_helper(method_name)
      send(method_name, arguments.first)
    else
      super
    end
  end

  def respond_to?(method_sym, include_private = false)
    if method_sym.to_s =~ /^(\w+)_attributes$/
      true
    else
      super
    end
  end



  protected

  def define_dynamic_attribute_helper(method_name)
    class_eval <<-RUBY
      def #{method_name}(object)
        present_attributes_for(__method__, object) || attributes
      end
    RUBY
  end



  private

  def present_attributes_for(method_caller, object)
    object = object.try(:first) || object
    presenter = presentify(object)
    presented_attributes = presenter.try(method_caller)
    presented_attributes
  end

  def presentify(object)
    begin
      "#{object.class}Presenter".constantize
    rescue NameError
      nil
    end
  end
end