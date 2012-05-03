module CartoCms
  module Generators
    class InstallGenerator < Rails::Generators::Base

      desc "Copy CartoCMS default files"

      source_root File.expand_path("../templates", __FILE__)

      class_option :subdomain, :type => :boolean, :default => false, :desc => "Route to CartoCMS via 'cms' subdomain"


      def add_routes
        source = options.subdomain? ? 'subdomain_route.rb' : 'namespace_route.rb'
        route_from_file source
      end

      def add_stylesheets
        remove_file 'app/assets/stylesheets/application.css'
        copy_file 'application.css.scss', 'app/assets/stylesheets/application.css.scss'
        copy_file 'variables.css.scss',   'app/assets/stylesheets/variables.css.scss'
      end

      def add_config_vars
        copy_file 'config_vars.yml', 'config/config_vars.yml'
        copy_file 'heroku.thor', 'lib/tasks/heroku.thor'
        append_to_file '.gitignore', 'config_vars.yml'
      end

      def add_humans
        copy_file 'humans.txt', 'public/humans.txt'
      end

      def copy_migrations
        migration_template 'migrations/users_migration.rb',          'db/migrate/devise_create_users.rb'
        migration_template 'migrations/pages_migration.rb',          'db/migrate/create_pages.rb'
        migration_template 'migrations/page_templates_migration.rb', 'db/migrate/create_page_templatess.rb'
        migration_template 'migrations/assets_migration.rb',         'db/migrate/create_assets.rb'
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