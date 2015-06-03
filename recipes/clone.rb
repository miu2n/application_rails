#
# Cookbook Name:: application_rails
# Recipe:: clone
#

path = node['application_rails']['install_location']
path = File.join(path, 'releases', 'initial') if node['application_rails']['install_capistrano']

ssh_dir = File.join(node['application_rails']['user_home'], '.ssh')

unless node['application_rails']['git_deploy_key'].empty?
  directory ssh_dir do
    user node['application_rails']['user']
    group node['application_rails']['group']
    mode 0700
    action :create
  end

  template File.join(ssh_dir, 'deploy-ssh-wrapper.sh') do
    source 'deploy-ssh-wrapper.erb'
    user node['application_rails']['user']
    group node['application_rails']['group']
    mode 0755
    variables({
      path: File.join(ssh_dir)
    })
  end

  file File.join(ssh_dir, 'id_deploy_key') do
    mode 0600
    content node['application_rails']['git_deploy_key']
    user node['application_rails']['user']
    group node['application_rails']['group']
  end
end

directory path do
  mode '0755'
  user node['application_rails']['user']
  group node['application_rails']['group']
  action :create
  recursive true
end

git 'clone application' do
  destination path
  repository node['application_rails']['git_repository']
  revision node['application_rails']['git_revision']
  user node['application_rails']['user']
  group node['application_rails']['group']
  ssh_wrapper File.join(ssh_dir, 'deploy-ssh-wrapper.sh') unless node['application_rails']['git_deploy_key'].empty?
  action :sync
end

link "#{node['application_rails']['install_location']}/current" do
  to path
end if node['application_rails']['install_capistrano']
