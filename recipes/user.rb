#
# Cookbook Name:: application_rails
# Recipe:: user
#

group node['application_rails']['group'] do
  gid node['application_rails']['user_gid']
end

user node['application_rails']['user'] do
  comment 'Rails deployment user'
  home node['application_rails']['user_home']
  shell node['application_rails']['user_shell']

  # We already created a user with specific gid so now we can supply the name
  # This line will make sure that we always have the correct group associated to the user
  # This is needed because if group id is nil chef won't supply -g to the useradd, see
  # https://github.com/opscode/chef/blob/11.4.4/lib/chef/provider/user/useradd.rb#L26
  gid node['application_rails']['group']
  supports manage_home: true
end

user node['application_rails']['user'] do
  action :lock
end
