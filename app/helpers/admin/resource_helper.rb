module Admin::ResourceHelper

  def attributes
    resource_class.attribute_names - %w(id position created_at updated_at)
  end
  
  def nested?(params)
    params.keys.each { |key| return key.gsub('_id', '').to_sym if key.end_with?('_id') }
  end

end