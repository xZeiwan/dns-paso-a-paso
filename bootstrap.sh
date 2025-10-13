# Script de provisión - Instalación del servidor DNS (BIND9)

set -e  # Detener si ocurre un error

echo "-----INICIO DE PROVISIÓN: INSTALACIÓN Y CONFIGURACIÓN DEL SERVIDOR DNS-----"

# Actualizar repositorios e instalar paquetes necesarios
echo "Instalando BIND9 y utilidades..."
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y bind9 bind9utils bind9-doc

# Habilitar y arrancar el servicio
echo "Iniciando y habilitando el servicio bind9..."
systemctl enable named
systemctl restart named

# Verificar instalación y versión
echo "Verificando instalación..."
named -v
systemctl status named --no-pager

# Crear carpeta compartida /vagrant/config si no existe
echo "Preparando carpeta compartida /vagrant/config..."
mkdir -p /vagrant/config

# Copiar automáticamente los archivos de configuración (si existen) desde la carpeta compartida config/ del anfitrión al sistema del invitado.
echo "Copiando archivos de configuración desde /vagrant/config (si existen)..."
if [ -f /vagrant/config/named.conf.options ]; then
  cp /vagrant/config/named.conf.options /etc/bind/
fi
if [ -f /vagrant/config/named.conf.local ]; then
  cp /vagrant/config/named.conf.local /etc/bind/
fi
if ls /vagrant/config/db.* 1> /dev/null 2>&1; then
  cp /vagrant/config/db.* /var/lib/bind/
fi

# Comprobación final del servicio
echo "Comprobando configuración..."
named-checkconf /etc/bind/named.conf # Verificar la sintaxis del archivo de configuración principal
echo "Comprobando estado final del servicio BIND9:"
systemctl status named --no-pager

echo "-----PROVISIÓN COMPLETADA: SERVIDOR DNS INSTALADO Y EN FUNCIONAMIENTO-----"