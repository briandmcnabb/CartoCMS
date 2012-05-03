module Cms::PositionHelper
  def position_id
    'positionable' if @position
  end

  def position_url
    url_for(action: 'position', controller: params[:controller], only_path: false)
  end

  def positioning_handle
    content_tag(:span, "[drag]") if @position
  end
end