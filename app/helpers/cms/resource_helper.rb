module Cms::ResourceHelper

  def attributes
    attributes = column_names - %w(id created_at updated_at)
    attributes = position(attributes)
    @attributes ||= params[:action] == 'index' ? remove_text_column_types(attributes) : attributes
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

  def position(attributes)
    index = attributes.index 'position'
    @position ||= attributes.slice! index if index
    attributes
  end

  def td(object, attribute, options = {})
    length = options[:length] || 20
    object.public_send(attribute.gsub('_id', '')).to_s.truncate(length)
  end

  def th(attribute)
    if @position
      humanized_column_name(attribute)
    else
      sortable humanized_column_name(attribute), remote:true
    end
  end



  private

  def columns_hash
    @columns_hash ||= resource_class.columns_hash.inject({}) { |memo, (key, value)| memo[key] = value.type; memo }
  end

  def humanized_column_name(attribute)
    resource_class.human_attribute_name(attribute)
  end

  def remove_text_column_types(attributes)
    attributes.map { |attribute| attribute unless columns_hash[attribute] == :text }.compact
  end
end