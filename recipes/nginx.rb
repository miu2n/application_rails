#
# Cookbook Name:: application_rails
# Recipe:: nginx
#

is_rhel = platform_family?("rhel")

package 'nginx' do
  action :install
end

root_path = node['application_rails']['install_location']
root_path = File.join(node['application_rails']['install_location'], 'current') if node['application_rails']['install_capistrano']

if is_rhel
  %w( default.conf ssl.conf virtual.conf ).each do |conf|
    file "/etc/nginx/conf.d/#{conf}" do
      action :delete
    end
  end
else
  link "/etc/nginx/sites-enabled/#{node['application_rails']['app_name']}" do
    to "/etc/nginx/sites-available/#{node['application_rails']['app_name']}"
  end

  file '/etc/nginx/sites-enabled/default' do
    action :delete
  end
end

path = is_rhel ? "/etc/nginx/conf.d/#{node['application_rails']['app_name']}.conf" : "/etc/nginx/sites-available/#{node['application_rails']['app_name']}"

template path do
  source 'nginx.erb'
  mode 0644
  variables({
    root_path: root_path
  })
end

service 'nginx' do
  action :enable
end

service 'nginx' do
  action :nothing
  subscribes :restart, "template[#{path}]", :immediately
end
