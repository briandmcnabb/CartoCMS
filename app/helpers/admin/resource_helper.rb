module Admin::ResourceHelper

  def nested?(params)
    params.keys.each { |key| return key.gsub('_id', '').to_sym if key.end_with?('_id') }
  end

  def th(attribute)
    if positionable?
      humanized_column_name(attribute)
    else
      sortable humanized_column_name(attribute), remote:true
    end
  end
  
  def td(object, attribute, options = {})
    length = options[:length] || 20
    object.public_send(attribute.gsub('_id', '')).to_s.truncate(length)
  end
  
  def column_names
    @column_names ||= columns_hash.keys
  end
  
  def attributes
    @attributes ||= column_names - %w(id created_at updated_at)
  end
  
  def index_attributes
    attributes.map { |attribute| attribute unless columns_hash[attribute] == :text }.compact
  end
  
  def column_types(keys=attributes)
    keys.map { |key| column_type(key) }
  end

  def column_type(key)
    columns_hash[key]
  end

  private

  def columns_hash
    @columns_hash ||= resource_class.columns_hash.inject({}) { |memo, (key, value)| memo[key] = value.type; memo }
  end
  
  def humanized_column_name(attribute)
    resource_class.human_attribute_name(attribute)
  end
end