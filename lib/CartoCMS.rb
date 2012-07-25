require "active_attr"
require "acts_as_list"
require "acts_as_singleton"
#require "asset_sync"
require "carrierwave"
require "cancan"
require "chronic"
require "client_side_validations"
require "devise"
require "devise_invitable"
require "enumerize"
#require "fog"
require "friendly_id"
require "geocoder"
require "gibbon"
require "haml-rails"
require "has_scope"
require "inherited_resources"
require "jquery-rails"
require "nokogiri"
require "omniauth"
require "rack-rewrite"
require "responders"
require "show_for"
require "simple_form"
require "simple_ace_input"
require "timezone"
require "twitter"
require "will_paginate"

require "CartoCMS/engine"


module CartoCMS
  # Utility Menu Items
  mattr_accessor :utility_menu_items
  @@utility_menu_items = %w()

  # CMS Resource Menu Items
  mattr_accessor :cms_resource_menu_items
  @@cms_resource_menu_items = %w(assets pages templates sliders)

  # App Resource Menu Items
  mattr_accessor :app_resource_menu_items
  @@app_resource_menu_items = %w()

  # Resource Menu Items
  mattr_accessor :resource_menu_items
  @@resource_menu_items = self.cms_resource_menu_items + self.app_resource_menu_items

  def self.setup
    yield self
  end
end