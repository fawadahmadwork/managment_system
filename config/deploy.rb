# config valid for current version and patch releases of Capistrano
lock "~> 3.18.0"
set :application, "managment_system"
set :repo_url, 'git@github.com:fawadahmadwork/managment_system.git'
set :ssh_options, keys: ["/Users/macbook/Desktop/mang.pem"]

set :branch, :main
# set :deploy_to, '/home/deploy/managment_system'
# set :use_sudo, true
# set :linked_files, %w{config/master.key config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-3.2.2' # Should match ruby version

set :rails_env, 'production'    
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
# set :linked_files, %w{config/database.yml config/master.key}
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :puma_rackup, -> { File.join(current_path, ‘config.ru’) }
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind,  "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, true
# set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
# namespace :deploy do
# desc 'Create Directories for Puma Pids and Socket'
# task :make_dirs do
# on roles(:app) do
# execute "mkdir #{shared_path}/tmp/sockets -p"
# execute "mkdir #{shared_path}/tmp/pids -p"
# end
# end
# before :start, :make_dirs
# end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

#  Default value for :linked_files is []
 append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
# config/deploy.rb

namespace :deploy do
  desc 'Upload database configuration to the server'
  task :upload_database_yml do
    on roles(:app) do
      upload!('config/database.yml', File.join(shared_path, 'config', 'database.yml'))
    end
  end
end

after 'deploy:check:linked_files', 'deploy:upload_database_yml'
