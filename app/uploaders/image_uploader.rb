class ImageUploader < CartoAssetsUploader
  include CarrierWave::RMagick

  # Extensions White List
  def extensions_white_list
    %w(gif jpeg jpg png)
  end

  version :thumb do
    process resize_to_fill: [60, 60]
  end
end