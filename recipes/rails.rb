#
# Cookbook Name:: application_rails
# Recipe:: rails
#

include_recipe 'application_rails::clone' if node['application_rails']['git_integration']

# Install required gems
include_recipe "application_rails::gems"

# Configure and install app
include_recipe "application_rails::install"

# Start App Server
#include_recipe "::start"
