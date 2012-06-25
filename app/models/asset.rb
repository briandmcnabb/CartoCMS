class Asset < ActiveRecord::Base
  extend FriendlyId
  friendly_id :asset_name, use: [:slugged, :history]

  include Rails.application.routes.url_helpers

  mount_uploader :asset_path, AssetUploader

  # Accessors
  attr_accessible :asset_path

  # Associations
  belongs_to :attachable, polymorphic: true

  # Callbcks
  before_save :update_asset_attributes

  # Scopes
  scope :unassociated, where(attachable_id: nil)


  # Allow subclasses to use parent’s routes
  def self.inherited(subclass)
    subclass.instance_eval do
      def model_name
        Asset.model_name
      end
    end
    super
  end

  # Format data for use by jQuery File Uploader
  def to_jq_upload
   {
    name: read_attribute(:asset_path),
    size: asset_path.size,
    url: asset_path.url,
    delete_path: cms_asset_path(id)
   }
  end


  private

  def asset_name
    asset_path.to_s.split('/').last.split('.').reverse.drop(1).reverse.join('.')
  end

  # Save asset attributes
  def update_asset_attributes
    if asset_path.present? && asset_path_changed?
      self.content_type = asset_path.file.content_type
      self.file_size    = asset_path.file.size
    end
  end
end