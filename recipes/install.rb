#
# Cookbook Name:: application_rails
# Recipe:: install
#

# Create shared capistrano folders
node['application_rails']['capistrano_shared_folders'].each do |folder|
  shared_path = File.join(node['application_rails']['install_location'], 'shared', folder)
  app_path = File.join(node['application_rails']['install_location'], 'current', folder)

  directory shared_path do
    owner node['application_rails']['user']
    group node['application_rails']['group']
    mode 0755
    not_if { File.exists?(shared_path) }
  end
end if node['application_rails']['install_capistrano']

# Create database config
if node['application_rails']['install_capistrano'] && node['application_rails']['capistrano_shared_database']
  config_path = File.join(node['application_rails']['install_location'], 'shared', 'config')
else
  config_path = File.join(node['application_rails']['install_location'], 'config')
end

directory config_path do
  owner node['application_rails']['user']
  group node['application_rails']['group']
  mode 0755
  recursive true
  not_if { File.exists?(path) }
end

template File.join(config_path, 'database.yml') do
  source 'database.yml.erb'
  user node['application_rails']['user']
  group node['application_rails']['group']
  mode 0700 # Set the database file to only be usable for the user
end

# Create secrets config
template File.join(config_path, 'secrets.yml') do
  source 'secrets.yml.erb'
  user node['application_rails']['user']
  group node['application_rails']['group']
  mode 0700 # Set the secrets file to only be usable for the user
end

root_path = node['application_rails']['install_location']
root_path = File.join(root_path, 'current') if node['application_rails']['install_capistrano']

%w{database.yml secrets.yml}.each do |f|
  file File.join(root_path, 'config', f) do
    action :delete
  end

  link File.join(root_path, 'config', f) do
    to File.join(config_path, f)
  end
end if node['application_rails']['install_capistrano']

# Create directories for PID and SOCK files
%w{tmp/pids tmp/sockets}.each do |dir|
  directory File.join(root_path, dir) do
    owner node['application_rails']['user']
    group node['application_rails']['group']
    mode 0755
    recursive true
    not_if { File.exists?(path) }
  end
end

# Create init
execute 'foreman export' do
  command "foreman export upstart /etc/init -a #{node['application_rails']['app_name']} -u #{node['application_rails']['user']}"
  cwd root_path
end

# Load DB Schema
execute 'rake db:schema:load' do
  command 'bundle exec rake db:schema:load'
  cwd root_path
  user node['application_rails']['user']
  group node['application_rails']['group']
  environment({ 'RAILS_ENV' => node['application_rails']['rails_env'] })
end

# Migrate DB
execute 'rake db:migrate' do
  command 'bundle exec rake db:migrate'
  cwd root_path
  user node['application_rails']['user']
  group node['application_rails']['group']
  environment({ 'RAILS_ENV' => node['application_rails']['rails_env'] })
end

if node['application_rails']['rails_env'] == 'production'
  # Clean assets
  execute 'rake assets:clean' do
    command 'bundle exec rake assets:clean'
    cwd root_path
    user node['application_rails']['user']
    group node['application_rails']['group']
    environment({ 'RAILS_ENV' => node['application_rails']['rails_env'] })
  end

  # Precompile assets
  execute 'rake assets:precompile' do
    command 'bundle exec rake assets:precompile'
    cwd root_path
    user node['application_rails']['user']
    group node['application_rails']['group']
    environment({ 'RAILS_ENV' => node['application_rails']['rails_env'] })
  end
end

# Start application
execute 'start app' do
  command "start #{node['application_rails']['app_name']}"
  cwd root_path
  not_if "restart #{node['application_rails']['app_name']}"
end
