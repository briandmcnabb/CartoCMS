class Cms::ResourceController < Cms::ApplicationController
  inherit_resources

  respond_to :html, :js
  self.responder = Cms::Responder

  def create
    create!{ edit_resource_path }
  end

  def destroy
    destroy! do |format|
      format.js { render nothing: true }
    end
  end



private

  def config_new_resource_link(options={})
    @new_resource_link_config ||= options
  end
end