class Admin::PagesController < Admin::ResourceController
  def create
    create!{ edit_resource_path }
  end


  private

  def collection
    get_collection_ivar || begin
      c = end_of_association_chain
      set_collection_ivar(c.respond_to?(:scoped) ? c.scoped : c.all)
    end
  end
end