$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "CartoCMS/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "CartoCMS"
  s.version     = CartoCMS::VERSION
  s.authors     = ["Brian McNabb"]
  s.email       = ["brian@new-cartographers.com"]
  s.homepage    = "http://new-cartographers.com"
  s.summary     = "A drop-in backend rails engine with some nice extras."
  s.description = "A drop-in backend rails engine with some nice extras."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails",                   ">= 3.1.0"
  s.add_dependency "active_attr"
  s.add_dependency "acts_as_list"
  s.add_dependency "acts_as_singleton"
  s.add_dependency "asset_sync"
  s.add_dependency "carrierwave"
  s.add_dependency "cancan"
  s.add_dependency "chronic"
  s.add_dependency "client_side_validations", "~> 3.2.0.beta.3"
  s.add_dependency "devise",                  ">= 2.0.0"
  s.add_dependency "devise_invitable",        "~> 1.0.0"
  s.add_dependency "enumerize",               "~> 0.0.4"
  s.add_dependency "fog"
  s.add_dependency "foreman"
  s.add_dependency "friendly_id",             "~> 4.0.1"
  s.add_dependency "geocoder"
  s.add_dependency "gibbon"
  s.add_dependency "haml-rails"
  s.add_dependency "has_scope"
  s.add_dependency "heroku"
  s.add_dependency "inherited_resources"
  s.add_dependency "jquery-rails"
  s.add_dependency "nokogiri"
  s.add_dependency "omniauth", "~> 1.0"
  s.add_dependency "rack-rewrite"
  s.add_dependency "responders"
  #s.add_dependency "rmagick"
  s.add_dependency "show_for"
  s.add_dependency "simple_form",             "~> 2.0"
  s.add_dependency "simple_ace_input",        "~> 0.0.1.rc"
  s.add_dependency "thin"
  s.add_dependency "timezone"
  s.add_dependency "twitter"
  s.add_dependency "will_paginate",           "~> 3.0"

  s.add_development_dependency "rspec-rails", "~> 2.8.1"
  s.add_development_dependency 'sqlite3'
end
