module CartoCMS
  class Engine < Rails::Engine
    # Load Config Vars
    config.before_configuration do
      load(File.expand_path('../config_var_loader.rb', __FILE__))
    end

    # Use CartoCMS scaffold generator
    #config.generators.scaffold_generator = :carto_cms_scaffold_generator

  end
end
