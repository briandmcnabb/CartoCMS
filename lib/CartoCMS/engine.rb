require 'rails'

module CartoCMS
  class Engine < Rails::Engine

    # Rack Rewrite - No WWW
    config.app_middleware.insert_before(Rack::Lock, Rack::Rewrite) do
      r301 /.*/,  Proc.new { |path, rack_env| binding.pry; "http://#{rack_env['HTTP_HOST'].gsub(/www\./i, '') }$&" },
          :if => Proc.new { |rack_env| rack_env['SERVER_NAME'] =~ /www\./i }
    end


    config.before_configuration do |app|
      # Load Config Vars
      load(File.expand_path('../config_var_loader.rb', __FILE__))

      # Force application to not access the DB or load models when precompiling assets
      app.config.assets.initialize_on_precompile = false

      # Use Letter Opener in Development
      if Rails.env.development?
        app.config.action_mailer.delivery_method = :letter_opener
      end
    end


    # Precompile Assets
    initializer :assets, group: :all do |app|
      app.config.assets.precompile += %w(carto_simple_ace_input.js mercury.js mercury.css CartoCMS.js CartoCMS.css boilerplate.css)
    end


    # Set Geonames Username
    Timezone::Configure.begin do |c|
      c.username = ENV['GEONAMES_USERNAME']
    end
  end
end