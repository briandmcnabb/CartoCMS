module SliderHelper

  def slider(slider, options={})
    # Defaults
    options[:caption]  = sanitized_caption(options[:caption])
    options[:position] ||= 'relative'
    options[:size]     ||= :xx_large

    # Generate slider hash
    slider_hash = slider.slides.inject({slides: [], captions: []}) do |memo, slide|
      if slide.image
        memo[:slides]   << image_tag(slide.image.asset_path.url(options[:size]), alt: slide.name, title: send(options[:caption], slide))
        memo[:captions] << div_for(slide, class: 'nivo-html-caption'){ slide.description } if html_caption?
      end
      memo
    end

    # Load Script
    unless slider_hash[:slides].empty?
      content_for(:extra_scripts) do
        javascript_tag do
            "$(window).load(function() {
              $('##{dom_id(slider)}').nivoSlider();
            });"
        end
      end
    end

    # Output
    out = ''
    out << div_for(slider, class: 'nivo_slider', style: "position: #{options[:position]};"){ slider_hash[:slides].join.html_safe }
    out << slider_hash[:captions].join.html_safe
    out.html_safe
  end


private

  def sanitized_caption(type='html')
    @sanitized_caption ||= case type
    when 'inline'
      'inline_caption'
    else
      'html_caption'
    end
  end

  def html_caption(slide)
    "##{dom_id(slide)}"
  end

  def html_caption?
    sanitized_caption == 'html_caption'
  end

  def inline_caption(slide)
    slide.description
  end
end
