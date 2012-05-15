class Cms::PagesController < Cms::ResourceController
  require 'mercury/params_mapper'
  include Mercury::ParamsMapper
  respond_to :json

  def update
    @page = Page.find(params[:id])
    normalize_params_hash(@page) if mercury_update?
    update! { edit_resource_path }
  end



  private

  def collection
    get_collection_ivar || begin
      c = end_of_association_chain
      set_collection_ivar(c.respond_to?(:scoped) ? c.scoped : c.all)
    end
  end
end