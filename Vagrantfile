Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.network "private_network", ip: "192.168.56.10"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.synced_folder "./wordpress", "/vagrant/wordpress"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus   = 2
    vb.name   = "webfusion-wordpress-vm"
  end
  config.vm.provision "shell", path: "provision.sh"
end
