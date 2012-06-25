class Cms::OmniauthController < Cms::ApplicationController

  def callback
    OmniauthAuthenticator.find_or_create_authentication(connectable.connections, auth_hash)
    redirect_to [:cms, @connectable.class.to_s.singularize.downcase, Connection], notice: "Success! Your #{auth_hash.provider} account is connected!"
  end

  def failure
    redirect_to [:cms, @connectable.class.to_s.singularize.downcase, Connection], alert: "authentication failed due to a(n) #{params[:message].humanize.downcase}"
  end


protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def connectable
    @connectable ||=  Settings.instance
  end
end