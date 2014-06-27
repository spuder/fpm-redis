# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.synced_folder ".", "/vagrant_data"
  #config.vm.synced_folder ".", "/tmp/builder", create: true
  #config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network :private_network, type: "dhcp"


  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.define "centos", primary: true do |centosbox|
    centosbox.vm.box = "centos-6_5-x64-virtualbox_4_3-plain"
    centosbox.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"
  end

  config.vm.define "ubuntu", autostart: false do |ubuntubox|
    ubuntubox.vm.box = "ubuntu-12_04-x64-virtualbox_4_2_10-plain"
    ubuntubox.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
  end
  
  config.vm.define "sles", autostart: false do |slesbox|
    slesbox.vm.box = "sles-11_sp1-x64-virtualbox_4_2_10-plain"
    slesbox.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/sles-11sp1-x64-vbox4210.box"
  end

  config.vm.define "debian", autostart: false do |debianbox|
    debianbox.vm.box = "debian-7_3-x64-virtualbox_4_3-plain"
    debianbox.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-73-x64-virtualbox-puppet.box"
  end

end
