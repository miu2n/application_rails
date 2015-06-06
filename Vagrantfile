# -*- mode: ruby -*-
# vi: set ft=ruby :

plugins = { 'vagrant-berkshelf' => '4.0.4', 'vagrant-omnibus' => nil }

plugins.each do |plugin, version|
  unless Vagrant.has_plugin? plugin
    error = "The '#{plugin}' plugin is not installed! Try running:\nvagrant plugin install #{plugin}"
    error += " --plugin-version #{version}" if version
    raise error
  end
end

FORWARD = ENV['NOTE_HOUSE_VAGRANT_FORWARD'] || '0'

Vagrant.configure(2) do |config|
  config.vm.hostname = "note-house-dev"

  config.vm.box = "ubuntu/trusty64"
#  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine.
  if FORWARD.to_i > 0
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "forwarded_port", guest: 3000, host: 3000
  end

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider :virtualbox do |vb|
   vb.name = "note_house_#{Time.now.getutc.to_i}"

   # Customize the VM settings:
   vb.memory = "2048"
   vb.cpus = 2
  end

  config.berkshelf.enabled = true
  config.omnibus.chef_version = '11.4.4'

  config.vm.provision :chef_solo do |chef|
    # chef.cookbooks_path = ""
    # chef.data_bags_path = ""
    # chef.environments_path = ""
    # chef.environment = ""
    # chef.recipe_url = ""
    # chef.roles_path = ""
    # chef.synced_folder_type = ""
    # chef.add_recipe ""
    # chef.add_role ""
    # chef.json = {}
    chef.run_list = [
      "application_rails"
    ]
  end
end
