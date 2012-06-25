class Cms::ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_timezone

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to cms_root_url, alert: exception.message
  end


private

  def set_timezone
    if user_signed_in?
      Time.zone = current_user.time_zone
    end
  end
end