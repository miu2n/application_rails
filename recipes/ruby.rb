#
# Cookbook Name:: application_rails
# Recipe:: ruby
#

include_recipe 'ruby_build'

ruby_build_ruby node['application_rails']['ruby_version'] do
  prefix_path '/usr/local/'
  notifies :install, 'gem_package[bundler]', :immediately
end

gem_package 'bundler' do
  gem_binary '/usr/local/bin/gem'
  options '--no-ri --no-rdoc'
  action :nothing
end
