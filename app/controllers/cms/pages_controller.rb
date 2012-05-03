class Cms::PagesController < Cms::ResourceController
  require 'mercury/params_mapper'
  include Mercury::ParamsMapper
  respond_to :json

  def create
    create!{ edit_resource_path }
  end

  def update
    @page = Page.find(params[:id])
    normalize_params_hash(@page) if mercury_update?
    #if mercury_update?
    #  map_virtual_content_fields_to(@page.body)
    #end
    update!
  end



  private

  def collection
    get_collection_ivar || begin
      c = end_of_association_chain
      set_collection_ivar(c.respond_to?(:scoped) ? c.scoped : c.all)
    end
  end
end