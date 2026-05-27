# Laboratório para aprender a subir uma VM com o Vagrant

## Pré-requisitos:
Windows 8+
Instalar Vagrant - Next next finish no setup
Instalar Oracle VirtualBox - Next next finish no setup também


## Comandos úteis Vagrant:
### Iniciar vagrant
vagrant init

### Subir VM
vagrant up

### Entrar na VM por SSH
vagrant ssh

###  Ver status da VM
vagrant status

###  Parar VM
vagrant halt

### Reiniciar a VM ou arquivo provision (sem destruir a VM)
vagrant reload
vagrant reload --provision

###  Destruir VM
vagrant destroy -f

### Verificar boxes instaladas
vagrant box list


###  Exemplo de Vagrantfile:
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provision "shell", path: "provision.sh"
end
    vb.memory = "4096"
    vb.cpus = 2
  end
end

###  Exemplo de provision.sh:
#!/bin/bash


apt-get update
apt-get install -y nginx
cp -r /vagrant/site/* /var/www/html/
systemctl enable nginx
systemctl restart nginx


###  Configurar IP fixo
config.vm.network "private_network", ip: "xxx.xxx.xxx"

###  Aplicar mudanças
vagrant reload

###  Você pode automatizar instalação
###  Exemplo:
###  Instalar Docker automaticamente.

config.vm.provision "shell", inline: <<-SHELL
  apt update
  apt install -y docker.io
SHELL



# Troubleshooting:
###  Como verificar se o Vagrant detectou o VirtualBox
vagrant global-status

###  Verificar plugin instalado
vagrant plugin list

###  Reinstalar plugins
vagrant plugin expunge --reinstall

vagrant plugin install vagrant-vbguest

# Desinstalar todos os plugins
vagrant plugin uninstall vagrant-vbguest