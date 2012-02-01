$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "CartoCMS/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "CartoCMS"
  s.date        = Time.now
  s.version     = CartoCMS::VERSION
  s.platform    = Gem::Platform::Ruby
  s.authors     = ["Brian McNabb"]
  s.email       = ["brian@new-cartographers.com"]
  s.homepage    = "http://new-cartographers.com"
  s.summary     = "A drop-in backend rails engine with some nice extras."
  s.description = "A drop-in backend rails engine with some nice extras."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "inherited_resources"
  s.add_dependency "has_scope"
  s.add_dependency "responders"
  s.add_dependency "simple_form"
  s.add_dependency "show_for"
  s.add_dependency "will_paginate"
  s.add_dependency "acts_as_list"
  s.add_dependency "haml-rails"
  

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.8.1"
  s.add_development_dependency "capybara", "~> 1.1.2"
  
end
