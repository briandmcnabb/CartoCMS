class Cms::AssetsController < Cms::ResourceController
  # Filters
  before_filter :normalize_asset_path, only: 'create'
  before_filter :set_asset_type, only: 'create'

  # Configuration
  defaults resource_class: @resource_class || Asset
  actions :index, :create, :edit, :update, :destroy

  belongs_to :slide,  polymorphic: true, optional: true
  belongs_to :story,  polymorphic: true, optional: true
  belongs_to :person, polymorphic: true, optional: true
  belongs_to :work,   polymorphic: true, optional: true

  respond_to :json
  respond_to :js, only: :destroy

  # Actions
  def index
    index! do |format|
      format.json { render json: collection.collect { |r| r.to_jq_upload }.to_json }
    end
  end

  def create
    @asset = parent.send("build_#{@resource_class}",params[:asset]) if parent_exist
    create! do |success, failure|
      success.html { render json: [resource.to_jq_upload].to_json, content_type: 'text/html', layout: false }
      success.json { render json: [resource.to_jq_upload].to_json }
      failure.json { render json: [{error: "custom_failure"}], status: 304 }
    end
  end

  def edit
    session[:return_to] = request.referer
    edit!
  end

  def update
    update! do |success, failure|
      success.html { redirect_to session[:return_to] }
    end
  end



private

  def collection
    get_collection_ivar || begin
      c = end_of_association_chain.unassociated.order("created_at DESC").scoped
      set_collection_ivar(c)
    end
  end

  def parent_exist
    respond_to?('parent') ? parent : nil
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
    @resource_class = parent_exist ? klass : klass.capitalize.constantize
  end
end