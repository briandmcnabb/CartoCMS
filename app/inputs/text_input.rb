class TextInput < SimpleForm::Inputs::Base
  enable :placeholder, :maxlength

  def input
    input_html_options[:rows] ||= 5
    @builder.text_area(attribute_name, input_html_options)
  end
end