module SliderHelper

  def slider(slider, options={})
    # Defaults
    options[:caption]  = sanitized_caption(options[:caption])
    options[:position] ||= 'relative'
    options[:size]     ||= :xx_large
    options[:theme]    ||= 'theme-default'

    # Generate slider hash
    slider_hash = slider.slides.inject({slides: [], captions: []}) do |memo, slide|
      if slide.image
        memo[:slides]   << image_tag(slide.image.asset_path.url(options[:size]), alt: slide.name, title: send(options[:caption], slide))
        memo[:captions] << div_for(slide, class: 'nivo-html-caption'){ content_tag(:div, slide.description.html_safe, class: 'wrapper') } if html_caption?
      end
      memo
    end

    # Load Script
    unless slider_hash[:slides].empty?
      content_for(:extra_scripts) do
        javascript_tag do
            "$(window).load(function() {
              $('##{dom_id(slider)}').nivoSlider({
                effect: 'fade',
                animSpeed: 1000,
                pauseTime: 6000
              });
            });"
        end
      end
    end

    slider_markup  = div_for(slider, class: 'nivoSlider', style: "position: #{options[:position]};"){ slider_hash[:slides].join.html_safe }
    caption_markup = slider_hash[:captions].join.html_safe

    # Output
    out = ''
    out << content_tag(:div, slider_markup, class: "slider_wrapper #{options[:theme]}").html_safe
    out << caption_markup.html_safe
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
