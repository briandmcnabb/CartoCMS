class Admin::AssetsController < Admin::ResourceController
  # Filters
  before_filter :normalize_asset_path, only: 'create'
  before_filter :set_asset_type, only: 'create'

  # Configuration
  defaults resource_class: @resource_class || Asset
  actions :index, :create, :destroy
  respond_to :json

  def index
    index! do |format|
      format.json { render json: collection.collect { |r| r.to_jq_upload }.to_json }
    end
  end

  def create
    @asset = parent.send(@resource_class).build(params[:asset]) if parent
    create! do |success, failure|
      success.html { render json: [resource.to_jq_upload].to_json, content_type: 'text/html', layout: false }
      success.json { render json: [resource.to_jq_upload].to_json }
      failure.json { render json: [{error: "custom_failure"}], status: 304 }
    end
  end


  private

  def collection
    get_collection_ivar || begin
      c = end_of_association_chain.order("created_at DESC").scoped
      set_collection_ivar(c)
    end
  end

  def normalize_asset_path
    params[:asset][:asset_path] = Array(params[:asset][:asset_path]).first
  end

  def set_asset_type
    asset = params[:asset][:asset_path]

    case asset.content_type.split('/').first
    when 'image' then set_resource_class :image
    else set_resource_class
    end
  end

  def set_resource_class(klass='asset')
    klass = klass.to_s
    @resource_class = parent ? klass.pluralize : klass.capitalize.constantize
  end
end