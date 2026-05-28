# Vagrant - Guia Completo

## O que é o Vagrant?

O Vagrant é uma ferramenta para criar e gerenciar ambientes virtualizados de forma automatizada usando arquivos declarativos.

Ele funciona junto com providers como:

- VirtualBox
- VMware
- Hyper-V
- Docker
- Libvirt
---

## Pré-requisitos:
#### Windows 8+ 
#### Instalar Vagrant - Next next finish no setup 
#### Instalar Oracle VirtualBox - Next next finish no setup também

## Ubuntu/Debian

```bash
sudo apt update
sudo apt install virtualbox -y
wget https://releases.hashicorp.com/vagrant/2.4.1/vagrant_2.4.1-1_amd64.deb
sudo dpkg -i vagrant_2.4.1-1_amd64.deb
```


### Criar projeto
```bash
mkdir lab-vagrant
cd lab-vagrant
vagrant init
```

### Criar Vagrantfile baseado em box
```bash
vagrant init ubuntu/jammy64
```

## Boxes
### Listar boxes instaladas
```bash
vagrant box list
```

### Adicionar box
```bash
vagrant box add ubuntu/jammy64
```

### Remover box
```bash
vagrant box remove ubuntu/jammy64
```

### Atualizar box
```bash
vagrant box update
```

### Procurar boxes
https://portal.cloud.hashicorp.com/vagrant/discover

## Comandos Básicos
### Subir VM
```bash
vagrant up
```

### Subir com provider específico
```bash
vagrant up --provider=virtualbox
```

## Acessar VM
```bash
vagrant ssh
```

## Parar VM
```bash
vagrant halt
```

## Reiniciar VM
```bash
vagrant reload
```

## Reiniciar aplicando provisionamento
```bash
vagrant reload --provision
```

## Destruir VM
```bash
vagrant destroy -f
```

## Ver status
```bash
vagrant status
```

## Suspender VM
```bash
vagrant suspend
```

## Retomar VM
```bash
vagrant resume
```

## Provisionamento
### Vagrantfile
```bash
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"

  config.vm.provision "shell", path: "scripts/provision.sh"

end
```

### scripts/provision.sh
```bash
#!/bin/bash

apt update
apt install nginx -y

systemctl enable nginx
systemctl start nginx
```

## Rede
### DHCP
```bash
config.vm.network "private_network", type: "dhcp"
IP Fixo
config.vm.network "private_network", ip: "192.168.56.10"
Port Forward
config.vm.network "forwarded_port", guest: 80, host: 8080
```


### Acesso:
```bash
http://localhost:8080
```


## Pastas Compartilhadas
### Compartilhar pasta local com VM
```bash
config.vm.synced_folder "./app", "/var/www/html"
```


## Recursos da VM
### CPU e Memória
```bash
config.vm.provider "virtualbox" do |vb|
  vb.memory = 4096
  vb.cpus = 2
end
Multi Machine
Exemplo com 2 VMs
Vagrant.configure("2") do |config|

  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/jammy64"
    web.vm.hostname = "web"

    web.vm.network "private_network", ip: "192.168.56.10"
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/jammy64"
    db.vm.hostname = "db"

    db.vm.network "private_network", ip: "192.168.56.11"
  end

end
```


### Subir todas
```bash
vagrant up
```

### Subir apenas uma
```bash
vagrant up web
```

### SSH em máquina específica
```bash
vagrant ssh db
```

## Vagrant + Docker
### Provisionamento Docker
```bash
#!/bin/bash

apt update

apt install docker.io -y

systemctl enable docker
systemctl start docker
Rodar container
docker run -d -p 80:80 nginx
```


## Logs e Debug
### Ver logs detalhados
```bash
vagrant up --debug
```

### Verificar SSH
```bash
vagrant ssh-config
```

### Validar Vagrantfile
vagrant validate



# Troubleshooting:
###  Como verificar se o Vagrant detectou o VirtualBox
```bash
vagrant global-status
```

###  Verificar plugin instalado
```bash
vagrant plugin list
```

###  Reinstalar plugins
```bash
vagrant plugin expunge --reinstall
```

```bash
vagrant plugin install vagrant-vbguest
```

```bash
vagrant plugin install vagrant-vbox-snapshot
```

### Desinstalar todos os plugins
```bash
vagrant plugin uninstall vagrant-vbguest
```

### Criar snapshot
```bash
vagrant snapshot save antes-update
```

### Listar snapshots
```bash
vagrant snapshot list
```

### Restaurar snapshot
```bash
vagrant snapshot restore antes-update
```



# Instalar Docker com o Vagrant
```bash
echo "Atualizando repositórios..."
apt-get update

echo "Instalando Docker..."
apt-get install -y \
docker-ce \
docker-ce-cli \
containerd.io \
docker-buildx-plugin \
docker-compose-plugin

echo "Habilitando Docker..."
systemctl enable docker
systemctl start docker
```


# Instalar Jenkins com o Vagrant
```bash
echo "Baixando Jenkins..."

wget -O /tmp/jenkins.deb \
https://pkg.jenkins.io/debian-stable/binary/jenkins_2.504.1_all.deb

echo "Instalando Jenkins..."
dpkg -i /tmp/jenkins.deb || apt-get install -f -y

echo "Adicionando o usuário vagrant ao grupo Docker para permitir o uso do Docker sem sudo"
sudo usermod -aG docker jenkins

echo "Habilitando Jenkins..."
systemctl enable jenkins
systemctl start jenkins
```


###  Exemplo completo de Vagrantfile:
```bash
Vagrant.configure("2") do |config|

  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/jammy64"

    web.vm.hostname = "web"

    web.vm.network "private_network", ip: "192.168.56.10"

    web.vm.network "forwarded_port",
      guest: 80,
      host: 8080

    web.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end

    web.vm.provision "shell", inline: <<-SHELL
      apt update
      apt install nginx -y

      systemctl enable nginx
      systemctl start nginx
    SHELL

  end

end
```


###  Exemplo de provision.sh:
```bash
#!/bin/bash

echo "Instalando dependências padrão..."
apt-get install -y \
openjdk-17-jdk \
wget \
curl \
gnupg2 \
ca-certificates \
lsb-release \
apt-transport-https \
software-properties-common

apt-get update
apt-get install -y nginx
cp -r /vagrant/site/* /var/www/html/
systemctl enable nginx
systemctl restart nginx
```
