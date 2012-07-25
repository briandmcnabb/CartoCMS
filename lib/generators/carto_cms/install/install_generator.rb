require 'rails/generators/migration'

module CartoCms
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)

      desc "Copy CartoCMS default files"

      class_option :subdomain, :type => :boolean, :default => false, :desc => "Route to CartoCMS via 'cms' subdomain"


      class << self
        def next_migration_number(path)
          unless @prev_migration_nr
            @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
          else
            @prev_migration_nr += 1
          end
          @prev_migration_nr.to_s
        end
      end

      def add_config_vars
        copy_file 'config_vars.yml', 'config/config_vars.yml'
        copy_file 'heroku.thor', 'lib/tasks/heroku.thor'
        append_to_file '.gitignore', 'config_vars.yml'
      end

      def add_initializer
        copy_file 'initializer.rb', 'config/initializers/CartoCMS.rb'
      end

      def add_layout
        remove_file 'app/view/layout/application.html.erb'
        copy_file 'application.html.haml', 'app/view/layout/application.html.haml'
      end

      def add_procfile
        copy_file 'Procfile', 'Procfile'
        copy_file '.env', '.env'
      end

      def add_routes
        source = options.subdomain? ? 'subdomain_route.rb' : 'namespace_route.rb'
        route_from_file source
      end

      def add_stylesheets
        remove_file 'app/assets/stylesheets/application.css'
        copy_file 'application.css.scss', 'app/assets/stylesheets/application.css.scss'
        copy_file 'variables.css.scss',   'app/assets/stylesheets/variables.css.scss'
      end

      def configure_haml
        append_to_file 'config/environment.rb' do
          <<-EOS

            # Turn off haml indentation so code blocks in pre's are formatted correctly
            Haml::Template.options[:ugly] = true
          EOS
        end
      end

      def copy_migrations
        migration_template 'migrations/assets_migration.rb',      'db/migrate/create_assets.rb'
        migration_template 'migrations/connections_migration.rb', 'db/migrate/create_connections.rb'
        migration_template 'migrations/pages_migration.rb',       'db/migrate/create_pages.rb'
        migration_template 'migrations/settings_migration.rb',    'db/migrate/create_settings.rb'
        migration_template 'migrations/sliders_migration.rb',     'db/migrate/create_sliders.rb'
        migration_template 'migrations/slides_migration.rb',      'db/migrate/create_slides.rb'
        migration_template 'migrations/slugs_migration.rb',       'db/migrate/create_friendly_id_slugs.rb'
        migration_template 'migrations/templates_migration.rb',   'db/migrate/create_templates.rb'
        migration_template 'migrations/users_migration.rb',       'db/migrate/create_users.rb'
      end

      def update_public_folder
        copy_file 'humans.txt', 'public/humans.txt'
        remove_file 'public/index.html'
      end


      private

      def route_from_file(source)
        source   = File.expand_path(find_in_source_paths(source.to_s))
        route_config = ::File.binread(source)
        route route_config
      end
    end
  end
end