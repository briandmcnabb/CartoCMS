module Admin::PositionHelper
  def positionable?
    attributes.include?('position')
  end
  
  def position_class
    'positionable' if positionable?
  end
  
  def position_url
    super if positionable?
  end
  
  def positioning_handle
    super if positionable?
  end
end