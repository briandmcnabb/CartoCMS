module CartoCMS
  class Engine < Rails::Engine
    # Load Config Vars
    config.before_configuration do
      load(File.expand_path('../config_var_loader.rb', __FILE__))
    end
  end
end
