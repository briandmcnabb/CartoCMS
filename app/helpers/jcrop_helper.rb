module JcropHelper

  def jcrop(source, options={})
    image_tag source, id: "cropbox", data: options
  end

  def aspect_ratio
    resource.attachable.slider.aspect_ratio if resource.attachable
  end
end