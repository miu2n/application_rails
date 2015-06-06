# Create the list of packages that are needed based on the OS
if platform_family?("rhel")
  packages = %w{
    libicu-devel libxslt-devel libyaml-devel libxml2-devel gdbm-devel libffi-devel zlib1g-devel
    libyaml-devel readline-devel curl-devel pcre-devel gcc-c++ cmake openssl-devel postgresql-devel
  }
else
  packages = %w{
    build-essential zlib1g-dev libyaml-dev libgdbm-dev libreadline-dev libncurses5-dev libffi-dev
    curl checkinstall libxml2-dev libxslt-dev libcurl4-openssl-dev libicu-dev python-docutils
    logrotate vim wget checkinstall cmake libpq-dev
  }
end

# The packages to be installed on the system
default['application_rails']['packages'] = packages

# General
default['application_rails']['app_name'] = 'app'
default['application_rails']['server_name'] = '_'

# NGINX Specific
default['application_rails']['web_install'] = true
default['application_rails']['upstream_server_name'] = node['application_rails']['app_name']

# Ruby
default['application_rails']['ruby_install'] = true
default['application_rails']['ruby_version'] = '2.1.2'

# User
default['application_rails']['user'] = 'deploy'
default['application_rails']['group'] = 'deploy'
default['application_rails']['user_uid'] = nil # Use to specify user id
default['application_rails']['user_gid'] = nil # Use to specify group id
default['application_rails']['user_home'] = '/home/deploy'
default['application_rails']['user_shell'] = '/bin/bash'

# Rails Application
default['application_rails']['install_location'] = File.join(node['application_rails']['user_home'], node['application_rails']['app_name']) # Use the base application directory for capistrano deployments
default['application_rails']['rails_env'] = 'production' # Rails ENV
default['application_rails']['rails_secret_key_base'] = nil

default['application_rails']['install_capistrano'] = true # Install for capistrano deployments

# Git
default['application_rails']['git_integration'] = false
default['application_rails']['git_deploy_key'] = nil # Provide a deployment key for private repositories
default['application_rails']['git_repository'] = nil
default['application_rails']['git_revision'] = 'HEAD'

# Database
default['application_rails']['database_install'] = false
default['application_rails']['database_type'] = 'postgresql' # Allowed: postgresql
default['application_rails']['database_hostname'] = 'localhost'
default['application_rails']['database_username'] = 'root'
default['application_rails']['database_password'] = 'change_me123'
default['application_rails']['database_database'] = 'app'
default['application_rails']['database_port'] = '5432'
