class Image < Asset
  mount_uploader :asset_path, ImageUploader

  # Attributes
  attr_accessible :crop_x, :crop_y, :crop_w, :crop_h, :height, :width
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  # Callbacks
  after_update :crop_image

  def to_jq_upload
   super.merge({
    edit_path:     edit_cms_asset_path(id),
    dropzone_url:   asset_path.url(:medium),
    thumbnail_url: asset_path.url(:xx_small)
   })
  end


private

  def crop_image
    asset_path.recreate_versions! if crop_x.present?
  end
end