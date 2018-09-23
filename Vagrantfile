# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
settings = YAML.load_file 'sindria.yml'

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = settings['vm_box']
  config.vm.define settings['vm_name']
  config.vm.hostname = settings['vm_hostname']
  
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  #config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: settings['ip_address']

  # Proxy configuration
  if settings.has_key?('proxy') && settings['proxy']
    config.proxy.http     = "http://proxy.reply.it:8080"
    config.proxy.https    = "http://proxy.reply.it:8080"
    config.proxy.no_proxy = "localhost,127.0.0.1"
  end

  config.ssh.forward_agent    = true
  config.ssh.insert_key       = false


  config.vm.provision "shell" do |s|
    ssh_prv_key = ""
    ssh_pub_key = ""
    if File.file?("#{Dir.home}/.sindria/vagrant@dev")
      ssh_prv_key = File.read("#{Dir.home}/.sindria/vagrant@dev")
      ssh_pub_key = File.readlines("#{Dir.home}/.sindria/vagrant@dev.pub").first.strip
    else
      puts "No SSH key found. You will need to remedy this before continue."
      exit(1)
    end
    s.inline = <<-SHELL
      if grep -sq "#{ssh_pub_key}" /home/vagrant/.ssh/authorized_keys; then
        echo "SSH keys already provisioned."
        exit 0;
      fi
      echo "SSH key provisioning."
      mkdir -p /home/vagrant/.ssh/
      touch /home/vagrant/.ssh/authorized_keys
      echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
      echo #{ssh_pub_key} > /home/vagrant/.ssh/vagrant@dev.pub
      chmod 644 /home/vagrant/.ssh/vagrant@dev.pub
      echo "#{ssh_prv_key}" > /home/vagrant/.ssh/vagrant@dev
      chmod 600 /home/vagrant/.ssh/vagrant@dev
      chown -R vagrant:vagrant /home/vagrant
      exit 0
    SHELL
  end


   # Configure path of private key for WSL (fix vagrant ssh)
   if settings.has_key?('wsl') && settings['wsl']
     config.ssh.private_key_path = ["~/.sindria/vagrant@dev"]
   end


  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
   config.vm.synced_folder "./", "/var/www/" + settings['app_name']

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     vb.gui = false
  
     # Customize the amount of memory on the VM:
     vb.memory = settings['vm_memory']
     
     # Setting VM name
     vb.name = settings['vm_name']
  end



  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
      yum update -y
      yum install epel-release -y
      yum install git vim wget curl nano htop nmap telnet unzip -y
  SHELL

  
  config.vm.provision "shell" do |s|
      s.name = "Installing NGINX reverse proxy and webserver..."
      s.path = "scripts/install-nginx.sh"
      s.args = settings['app_name']
  end


  config.vm.provision "shell" do |s|
      s.name = "Installing PHP..." 
      s.path = "scripts/install-php72.sh"                        
      s.args = settings['app_name']                              
  end                                                           


  config.vm.provision "shell" do |s|
      s.name = "Installing MariaDB..."
      s.path = "scripts/install-mariadb.sh"
      s.args = settings['app_name']                              
  end  


  config.vm.provision "shell" do |s|
      s.name = "Installing Docker..."
      s.path = "scripts/install-docker.sh"
      s.args = settings['app_name']                              
  end 


  config.vm.provision "shell" do |s|
      s.name = "Enable services..."
      s.path = "scripts/enable-services.sh"
      s.args = settings['app_name']                              
  end 


 config.vm.provision "shell" do |s|
      s.name = "Installing app..."
      s.path = "scripts/install-app.sh"
      s.args = settings['app_name']                              
  end   


  config.vm.provision "shell" do |s|
      s.name = "Run vagrant-ssh fixer..."
      s.path = "scripts/ssh-fixer.sh"
      s.args = settings['app_name']                              
  end                                                          


  #config.vm.provision "ansible" do |ansible|
  #  ansible.compatibility_mode = "auto"
  #  ansible.verbose = "-vvv"
  #  ansible.inventory_path="./ansible/hosts"
  #  ansible.limit=""
  #  ansible.playbook = "./ansible/lemp.yml"
  #  #ansible.host_key_checking = false
  #  #ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
  #  #ansible.sudo = true
  #end

end
