module Cms::AssociationHelper

  def assc(attr)
    attr.gsub('_id', '').to_sym
  end

end