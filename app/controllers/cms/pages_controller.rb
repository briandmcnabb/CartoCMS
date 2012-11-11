class Cms::PagesController < Cms::ResourceController
  before_filter ->{ config_new_resource_link(modal: true) }, only: [:index]
  require "mercury/params_mapper"
  include Mercury::ParamsMapper
  respond_to :json

  def update
    @page = Page.find(params[:id])
    normalize_params_hash(@page) if mercury_update?
    update! { edit_resource_path }
  end
end