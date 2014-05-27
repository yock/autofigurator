namespace :autofigurator do
  task :create do
    shared_paths = fetch :shared_paths, []
    roles = fetch :autofigurator_roles
    Dir.glob(fetch :autofigurator_glob) do |file_name|
      shared_paths << file_name
      config = Autofigurator::Config.new(file_name, stage.to_s)
      config.build
      config.upload roles
    end
    set :shared_paths, shared_paths
  end

end

namespace :load do
  task :defaults do
    set :autofigurator_roles, ->{ [ :app, :web ] }
    set :autofigurator_glob, ->{ './config/*.yml.example' }
    set :autofigurator_environment, ->{ fetch :rails_env, 'production' }
  end
end

