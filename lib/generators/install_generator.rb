module CartoCms
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    # all public methods in here will be run in order
    def config_vars_yaml
      template "config_vars.yml", "config/config_vars.yml"
    end
  end
end