# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

# Network range: 10.240.0.0/24
# see https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/03-compute-resources.md

#
# Kubernetes Controllers
#
# IPs: 10.240.0.10, 10.240.0.11, 10.240.0.12
# Names: controller-0, controller-1, ...
(0..2).each do |i|

  config.vm.define "controller-#{i}" do |config|
    config.vm.box = "bento/ubuntu-18.04"
    #config.vm.box = "hashicorp/bionic64"
    config.vm.box_check_update = false
    config.vm.hostname = "controller-#{i}"
    config.vm.synced_folder ".", "/vagrant", disabled: true
    
    config.vm.network "private_network", ip: "10.240.0.1#{i}"
    #config.vm.network "private_network", ip: "10.240.0.10", netmask: "24"
    
    $apt_get_update = <<-SCRIPT
       sudo apt-get update; sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade;
       sudo shutdown -r now;
    SCRIPT
    config.vm.provision "shell", inline: $apt_get_update
    
    config.vm.provider "vmware_desktop" do |vmware|
      vmware.vmx["displayname"] = "Controller-#{i}"
      vmware.memory = "4096"
      vmware.cpus = "1"
      vmware.gui = false 
    end

  end

end

#
# Kubernetes Workers
#
# IPs: 10.240.0.20, 10.240.0.21, 10.240.0.22
# Names: worker-0, worker-1, ...
(0..2).each do |i|

  config.vm.define "worker-#{i}" do |config|
    config.vm.box = "bento/ubuntu-18.04"
    config.vm.box_check_update = false
    config.vm.hostname = "worker-#{i}"
    config.vm.synced_folder ".", "/vagrant", disabled: true
    
    config.vm.network "private_network", ip: "10.240.0.2#{i}"
    
    $apt_get_update = <<-SCRIPT
       sudo apt-get update; sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade;
       sudo shutdown -r now;
    SCRIPT
    config.vm.provision "shell", inline: $apt_get_update
    
    config.vm.provider "vmware_desktop" do |vmware|
      vmware.vmx["displayname"] = "Worker-#{i}"
      vmware.memory = "4096"
      vmware.cpus = "1"
      vmware.gui = false 
    end

  end

end

end
