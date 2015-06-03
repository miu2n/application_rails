#
# Cookbook Name:: application_rails
# Recipe:: default
#
# Copyright 2015, Nikko Miu
#
# All rights reserved - Do Not Redistribute
#

# Install required packages
include_recipe 'application_rails::packages'

include_recipe 'application_rails::user'

# Install ruby if ruby_install is true
include_recipe 'application_rails::ruby' if node['application_rails']['ruby_install']

# Install nginx if web_install is true
include_recipe 'application_rails::nginx' if node['application_rails']['web_install']

# Install database if database_install is true
include_recipe "application_rails::database_#{node['application_rails']['database_type']}" if node['application_rails']['database_install']

# Install rails app
include_recipe 'application_rails::rails'
