module Admin::SortHelper
  def sortable?
    resource_class.attribute_names.include?('position')
  end
  
  def sort_url
    if sortable?
      url_for(action: 'sort', controller: params[:controller], only_path: false)
    end
  end
end