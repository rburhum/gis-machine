# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Build based on Ubuntu Linux precise64
  config.vm.box = "precise64"

  # Fetch the virtual machine from the following URL
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Run bootstrap.sh
  config.vm.provision :shell, :path => "./setup/bootstrap.sh"

  # Port forward the VM's postgresql port (5432) to a local port (5433)
  config.vm.network :forwarded_port, guest: 5432, host: 5433

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network


  # Share folder with map source data
  #
  # For reference, the first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  config.vm.synced_folder ".", "/gistools"

  # Specify 2GB of RAM and 1 CPU for VirtualBox VM

  config.vm.provider :virtualbox do |vb|
    # Don't boot with headless mode
    # vb.gui = true

    vb.customize [
                    "modifyvm", :id,
                    "--memory", "2048",
                    "--cpus", "1"
                 ]
  end


end
