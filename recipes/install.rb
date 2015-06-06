#
# Cookbook Name:: application_rails
# Recipe:: install
#

root_path = node['application_rails']['install_location']
root_path = File.join(root_path, 'current') if node['application_rails']['install_capistrano']

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
