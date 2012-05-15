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


    ## Rack Rewrite Rules
    #config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
    #  r301 /.*/,  Proc.new { |path, rack_env| "http://#{rack_env['SERVER_NAME'].gsub(/www\./i, '') }#{path}" },
    #      :if => Proc.new { |rack_env| rack_env['SERVER_NAME'] =~ /www\./i }
    #end
  end
end
