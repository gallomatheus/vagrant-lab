# Laboratório para aprender a subir uma VM com o Vagrant

## Pré-requisitos:
#### Windows 8+ 
#### Instalar Vagrant - Next next finish no setup 
#### Instalar Oracle VirtualBox - Next next finish no setup também

## Comandos úteis Vagrant:
### Iniciar vagrant
```bash
vagrant init
```

### Subir VM
```bash
vagrant up
```

### Entrar na VM por SSH
```bash
vagrant ssh
```

###  Ver status da VM
```bash
vagrant status
```

###  Parar VM
```bash
vagrant halt
```

### Reiniciar a VM ou arquivo provision (sem destruir a VM)
```bash
vagrant reload
vagrant reload --provision
```

###  Destruir VM
```bash
vagrant destroy -f

### Verificar boxes instaladas
vagrant box list


###  Exemplo de Vagrantfile:
```bash
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provision "shell", path: "provision.sh"
end
    vb.memory = "4096"
    vb.cpus = 2
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

###  Configurar IP fixo
```bash
config.vm.network "private_network", ip: "xxx.xxx.xxx"
```

###  Aplicar mudanças
```bash
vagrant reload
```

###  Você pode automatizar instalação
###  Exemplo:
###  Instalar Docker automaticamente.
```bash
config.vm.provision "shell", inline: <<-SHELL
  apt update
  apt install -y docker.io
SHELL
```


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

# Desinstalar todos os plugins
```bash
vagrant plugin uninstall vagrant-vbguest
```


# Instalar Docker
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


# Instalar Jenkins
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



