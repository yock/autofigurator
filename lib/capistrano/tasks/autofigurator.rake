namespace :autofigurator do
  task :config do
    configuration_templates.each do |file_name|
      config_file = ConfigFile.new(file_name, fetch(:stage).to_s)
      config = {}
      config_file.config.each_pair do |key, value|
        ask key, value
        config[key] = fetch(key)
      end
      upload(config, "#{shared_path}/config/#{config_file.filename}")
    end
  end

  def configuration_templates
    Dir.glob(fetch(:autofigurator_glob))
  end

  def upload(config, path)
    on roles(fetch(:autofigurator_roles)) do
      upload!(StringIO.new(YAML.dump(config)), path)
    end
  end

  namespace :load do
    task :defaults do
      set :autofigurator_glob, './config/*.yml.example'
      set :autofigurator_roles, :all
    end
  end
end
