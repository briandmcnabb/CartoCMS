jQuery ($)->
  new ImageCropper()


class ImageCropper
  constructor: ->
    crop_object = $('#cropbox')
    crop_object.Jcrop

      # Options
      aspectRatio: crop_object.data('aspect-ratio')
      boxWidth:    crop_object.data('box-width')
      boxHeight:   crop_object.data('box-height')
      minSize:     crop_object.data('min-size')
      maxSize:     crop_object.data('max-size')
      setSelect:   crop_object.data('set-select')
      bgColor:     crop_object.data('bg-color') || 'transparent'
      bgOpacity:   crop_object.data('bg-opacity') || 0.5

      # Events
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#asset_crop_x').val(coords.x)
    $('#asset_crop_y').val(coords.y)
    $('#asset_crop_w').val(coords.w)
    $('#asset_crop_h').val(coords.h)