module JcropHelper

  def jcrop(source, options={})
    image_tag source, id: "cropbox", data: options
  end
end