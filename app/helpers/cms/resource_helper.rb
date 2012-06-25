module Cms::ResourceHelper

  def assc(attr)
    attr.gsub('_id', '').to_sym
  end

  def attributes
    @attributes ||=
      if params[:action] == 'index'
        remove_text_column_types column_names
      else
        remove_system_updated_fields column_names
      end
  end

  def column_names
    @column_names ||= columns_hash.keys
  end

  def column_type(key)
    columns_hash[key]
  end

  def column_types(keys=attributes)
    keys.map { |key| column_type(key) }
  end

  def nested?(params)
    params.keys.each { |key| return key.gsub('_id', '').to_sym if key.end_with?('_id') }
  end

  def panel_header_type(action)
    case action
    when 'new', 'create'
      'new'
    when 'edit', 'update'
      'edit'
    else
      action
    end
  end

  def parent_resource(parent_object=nil)
    if respond_to?('parent')
      parent
    #elsif respond_to? ('resource')     # Need to figure out how to pass a manual path
    #  binding.pry                      # into the uploader.  Possibly via a parameter
    #  resource                         # passed into the'asset_uploader' helper method.
    else
      nil
    end
  end

  def position
    @position ||= column_names.index 'position'
  end

  def td(object, attribute, options = {})
    options[:length] ||= 20
    attribute_value = object.public_send(attribute.gsub('_id', ''))
    if attribute_value.respond_to? :strftime
      attribute_value.strftime '%d %b %Y @ %I:%M%P'
    else
      attribute_value.to_s.truncate(options[:length])
    end
  end

  def th(attribute)
    sortable attribute, title: humanized_column_name(attribute.gsub('_at', '')), remote: true
  end



  private

  def columns_hash
    @columns_hash ||= resource_class.columns_hash.inject({}) { |memo, (key, value)| memo[key] = value.type; memo }
  end

  def humanized_column_name(attribute)
    resource_class.human_attribute_name(attribute)
  end

  def remove_text_column_types(attributes)
    remove_system_updated_fields(attributes).map do |attribute|
      attribute unless columns_hash[attribute] == :text
    end.compact

  end

  def remove_system_updated_fields(attributes)
    attributes - %w(id position created_at updated_at)
  end
end