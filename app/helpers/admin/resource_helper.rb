module Admin::ResourceHelper

  def nested?(params)
    params.keys.each { |key| return key.gsub('_id', '').to_sym if key.end_with?('_id') }
  end

  
  def column_names
    @column_names ||= columns_hash.keys
  end
  
  def attributes
    @attributes ||= column_names - %w(id position created_at updated_at)
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
end