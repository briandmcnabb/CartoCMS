class CartoAssetsUploader < CarrierWave::Uploader::Base
  # Storage Directory
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end
end