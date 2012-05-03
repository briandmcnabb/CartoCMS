class Cms::PositionableResourceController < Cms::ResourceController

  def position
    params[resource_class.name.underscore].each_with_index do |id, index|
      resource_class.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  private

  def collection
    get_collection_ivar || begin
      c = end_of_association_chain.order('position')
      set_collection_ivar(c.respond_to?(:scoped) ? c.scoped : c.all)
    end
  end
end