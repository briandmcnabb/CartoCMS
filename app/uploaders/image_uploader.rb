class ImageUploader < CartoAssetsUploader
  include CarrierWave::RMagick

  # Extensions White List
  def extensions_white_list
    %w(gif jpeg jpg png)
  end

  version :full do
    process :store_dimensions
  end

  version :xx_large do
    process :crop
    resize_to_limit 1600, nil
  end

  version :x_large do
    process :crop
    resize_to_limit(1200, nil)
  end

  version :large do
    process :crop
    resize_to_limit(900, nil)
  end

  version :medium do
    process :crop
    resize_to_limit(600, nil)
  end

  version :small do
    process :crop
    resize_to_limit(400, nil)
  end

  version :x_small do
    process :crop
    resize_to_limit(200, nil)
  end

  version :xx_small do
    process :crop
    resize_to_limit(100, nil)
  end



private

  def crop
    if model.crop_x.present?
      crop_coordinates = scaled_crop_coordinates

      manipulate! do |img|
        x = crop_coordinates[:x]
        y = crop_coordinates[:y]
        w = crop_coordinates[:w]
        h = crop_coordinates[:h]
        img.crop!(x, y, w, h)
      end
    end
  end

  def crop_coordinates
    @crop_coordinates ||= scaled_crop_coordinates
  end

  def raw_crop_coordinates
    @raw_crop_coordinates ||= {
      x: model.crop_x.to_i,
      y: model.crop_y.to_i,
      w: model.crop_w.to_i,
      h: model.crop_h.to_i
    }
  end

  def scaled_crop_coordinates(cropping_width=825)
    if model.width > cropping_width
      raw_crop_coordinates.inject({}) do |memo, (key, value)|
        memo[key] = (value * model.width.to_f / cropping_width.to_f).round
        memo
      end
    else
      raw_crop_coordinates
    end
  end

  def store_dimensions
    if @file
      img = ::Magick::Image::read(@file.file).first
      if model
        model.width  = img.columns
        model.height = img.rows
      end
    end
  end
end