class Image < Asset
  mount_uploader :asset_path, ImageUploader
end