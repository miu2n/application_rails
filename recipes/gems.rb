#
# Cookbook Name:: application_rails
# Recipe:: rails_deploy
#

root_path = node['application_rails']['install_location']
root_path = File.join(root_path, 'current') if node['application_rails']['install_capistrano']

# Update the certificates so there are no random errors with bundler
directory '/opt/local/etc/certs' do
  owner node['application_rails']['user']
  group node['application_rails']['group']
  recursive true
  mode 0755
end

remote_file 'Fetch latest ca-bundle' do
  source 'http://curl.haxx.se/ca/cacert.pem'
  path '/opt/local/etc/certs/cacert.pem'
  owner node['application_rails']['user']
  group node['application_rails']['group']
  mode 0755
  action :create
end

# Update the system gems
execute 'Update rubygems' do
  command 'gem update --system'
end

# Install gems without ri and rdoc
template File.join(node['application_rails']['user_home'], '.gemrc') do
  source 'gemrc.erb'
  user node['application_rails']['user']
  group node['application_rails']['group']
  action :create
end

# Setup bundle without
bundle_without = []
case node['application_rails']['rails_env']
when 'production'
  bundle_without << 'development'
  bundle_without << 'test'
else
  bundle_without << 'production'
end

#ssl_certs = lazy { File.exists?('/opt/local/etc/certs/cacert.pem') } ? 'SSL_CERT_FILE=/opt/local/etc/certs/cacert.pem' : ''

# Bundle
execute 'bundle install' do
  command "bundle install --without #{bundle_without.join(" ")}"
  cwd root_path
  action :run
end
