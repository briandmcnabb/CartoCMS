module Admin::ResourceHelper

  def attributes
    attributes = resource_class.attribute_names - %w(id position created_at updated_at)
  end
  
  def index_attributes
    attributes.map { |attribute| attribute unless attribute_type(attribute) == :text }.compact
  end

  def nested?(params)
    params.keys.each { |key| return key.gsub('_id', '').to_sym if key.end_with?('_id') }
  end



  private
  
  def attribute_type(attribute_name) #:nodoc:
    column     = resource_class.columns_hash[attribute_name.to_s]
    column_type = column.try(:type)
    column_type.nil? ? :string : column_type
  end


end