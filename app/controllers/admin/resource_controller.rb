class Admin::ResourceController < Admin::ApplicationController
  inherit_resources
  respond_to :html, :js
  self.responder = Admin::Responder
  
  
  def destroy
    destroy! do |format|
      format.js { render nothing: true }
    end
  end
  
  
  private
  
  def collection
    get_collection_ivar || begin
      c = end_of_association_chain.search(params)
      set_collection_ivar(c)
    end
  end
end