class Cms::ConnectionsController < Cms::SettingsController
  actions :index, :destroy
  helper_method :omniauth_providers

  def index
    @connections = connectable.connections.all
    @providers   = omniauth_providers.map{|provider| provider.downcase} - @connections.map(&:provider)
    index!
  end

  def destroy
    destroy! {[:cms, @connectable.class.to_s.singularize.downcase, Connection]}
  end

protected

  def begin_of_association_chain
    connectable
  end

  def connectable
    @connectable ||=  Settings.instance
  end

  def omniauth_providers
    OmniAuth.strategies.inject([]) do |memo, strategy|
      strategy.descendants.map {|descendant| memo << descendant.to_s.demodulize}
      memo
    end
  end
end