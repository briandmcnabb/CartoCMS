require 'rails'

module CartoCMS
  class Engine < Rails::Engine
    # Load Config Vars
    config.before_configuration do
      load(File.expand_path('../config_var_loader.rb', __FILE__))
    end

    initializer :assets, group: :all do |app|
      app.config.assets.precompile += %w(carto_simple_ace_input.js mercury.js mercury.css mercury_overrides.css)
    end
  end
end
