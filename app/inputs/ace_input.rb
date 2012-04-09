class AceInput < SimpleForm::Inputs::Base
  def input
    ace = options.delete :ace
    mode  = ace[:mode]  || 'html'
    theme = ace[:theme] || 'carto_light'

    input_html_options.merge!({ data: { ace_mode: mode, ace_theme: theme }, hidden: true})
    base_styles = 'position: relative; height: 600px;'
    target = [object_name, attribute_name].join('_')

    out = ''
    out << @builder.text_area(attribute_name, input_html_options)
    out << template.content_tag(:div, '', id: 'editor', style: base_styles, data: { target: target })
    out.html_safe
  end
end