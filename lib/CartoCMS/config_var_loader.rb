heroku_config = ::Rails.root.join('config', 'config_vars.yml')
if File.exists?(heroku_config)
  config = YAML.load_file(heroku_config)
  config_vars = config.fetch(Rails.env, {})
  unless config_vars.nil?
    config_vars.each do |key, value|
      ENV[key.upcase] = value.to_s
    end
  end
end