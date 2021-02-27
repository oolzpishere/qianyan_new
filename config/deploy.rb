# config valid for current version and patch releases of Capistrano
lock "~> 3.15.0"

set :application, "qianyan_new"
set :repo_url, "https://github.com/oolzpishere/qianyan_new.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "/var/www/rails/#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

### capistrano/rails
# Defaults to :db role
set :migration_role, :app

# Defaults to the primary :db server
set :migration_servers, -> { primary(fetch(:migration_role)) }

# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true

# Defaults to [:web]
set :assets_roles, [:web, :app]

# Defaults to nil (no asset cleanup is performed)
# If you use Rails 4+ and you'd like to clean up old assets after each deploy,
# set this to the number of versions to keep
set :keep_assets, 2

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", 'public/uploads', 'public/assets', 'storage'

append :linked_files, "config/master.key"
namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
      end
    end
  end
end

### capistrano/puma
# set :puma_service_unit_env_file, '/etc/puma_systemd_environment_file'
set :nginx_sites_available_path, "/etc/nginx/sites-available"
set :nginx_sites_enabled_path, "/etc/nginx/sites-enabled"

### rbenv setting
set :rbenv_ruby, '2.7.2'
# set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_custom_path, "/home/ubuntu/.rbenv"
set :rbenv_prefix, "#{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_prefix, "source /home/ubuntu/.zshrc; #{fetch(:rbenv_path)}/bin/rbenv exec"

set :rbenv_map_bins, %w{rake gem bundle ruby rails puma pumactl}
set :rbenv_roles, :all # default value
