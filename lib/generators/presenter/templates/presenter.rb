class <%= class_name %>Presenter < BasePresenter
<%- attributes.each do |attribute| -%>
  
  def <%= attribute.name %>
    handle_none <%= class_name %>.<%= attribute.name %> do
      <%= class_name %>.<%= attribute.name %>
    end
  end
<%- end -%>

end