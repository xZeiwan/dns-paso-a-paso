# Vagrantfile para la práctica
Vagrant.configure("2") do |config|

  # Imagen base del sistema operativo
  config.vm.box = "ubuntu/jammy64"

  # Nombre interno de la máquina virtual
  config.vm.hostname = "dns-server"

  # Red privada con IP fija
  config.vm.network "private_network", ip: "192.168.56.10"

  # Después de crear la máquina, ejecutar el script de aprovisionamiento (bootstrap.sh)
  config.vm.provision "shell", path: "bootstrap.sh", privileged: true

  # Montar la carpeta actual en /vagrant dentro de la máquina virtual
  config.vm.synced_folder ".", "/vagrant"

  # Recursos asignados a la máquina virtual
  config.vm.provider "virtualbox" do |vb|

    # 1024 MB de RAM para que el servidor DNS funcione correctamente
    vb.memory = "1024" # Por defecto son 512 MB, pero para asegurarme de que el servidor DNS funcione bien, le asigno 1024 MB

    # 1 CPU asignada
    vb.cpus = 1
  end
end