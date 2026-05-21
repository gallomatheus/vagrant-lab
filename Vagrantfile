Vagrant.configure("2") do |config|

  config.vm.box = "debian/bookworm64"

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provision "shell", path: "provision.sh"

end