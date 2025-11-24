# Documentación — Práctica DNS: Configuración de un servidor

En este directorio se documenta paso a paso la práctica.
Incluye capturas en doc/images/ y explicaciones en formato Markdown.

## Índice
- 1.2 Documentación (este fichero)
- 3 Instalación de servidor DNS
- 4 Configuración del servidor

## 1.3 Infraestructura como código

Durante este punto se ha preparado la máquina virtual Debian Bullseye con Vagrant, se ha creado el script `bootstrap.sh` (por ahora vacío) y se ha comprobado que la carpeta compartida `config/` funciona correctamente.

### Ficheros creados
- `Vagrantfile`: define la máquina Debian Bullseye, su red privada y la provisión por script.
- `bootstrap.sh`: script de provisión.
- `config/`: carpeta compartida entre anfitrión e invitado (`/vagrant/config`).

### Capturas de pantalla

**Creación de la máquina Debian Bullseye**

![Creación de la máquina Debian](images/1.3-primer-vagrant-up.png)

## 3. Instalación del servidor DNS

He instalado el software BIND9 en Debian Bullseye desde los repositorios oficiales, comprobando su correcto funcionamiento.

### Capturas de pantalla

**Instalación BIND9**

![Instalación BIND9](images/3-vagrant-provision.PNG)

**Comprobar la versión de BIND9**

![Comprobar la versión de BIND9](images/3-comprobar-bind.PNG)

## 4. Configuración del servidor (Parámetros generales)

Configurar el servidor BIND9 para que funcione únicamente con IPv4 y verificar la estructura base de los ficheros de configuración.

### Capturas de pantalla

**Modificación de la línea `OPTIONS`**

![IPTV4](images/4-ipv4.PNG)

## 4.1 Configuración `named.conf.options`

Ajustar la configuración global del servidor BIND9 para que solo acepte consultas de equipos confiables, escuche únicamente en IPv4 y refuerce la seguridad general del servicio.

### Capturas de pantalla

**Copia de seguridad**

![IPTV4](images/4.1-copia-seguridad.PNG)

**Comprobar configuración**

![IPTV4](images/4.1-comprobar-configuracion.PNG)

## 4.2 Configuración `named.conf.local`

Declarar la zona directa del dominio personal `enrique.test`, indicando que este servidor DNS es el maestro de dicha zona.

### Capturas de pantalla

**Archivo named.conf.local**

![named.conf.local](images/4.2-named.conf.local.PNG)

## 4.3 Creación del archivo de zona

Crear el archivo de zona directa del dominio `enrique.test`, donde se definen los registros DNS básicos (SOA, NS y A).

### Capturas de pantalla

**Archivo enrique.test.dns**

![named.conf.local](images/4.3-enrique.test.dns.PNG)

## 4.4 Zona para la resolución inversa

Añadir la zona inversa que permita resolver direcciones IP dentro de la red `192.168.58.0/24` hacia nombres de dominio (`PTR`).

### Capturas de pantalla

**Archivo named.conf.local**

![named.conf.local](images/4.4-named.conf.local.PNG)

**Archivo enrique.test.rev**

![named.conf.local](images/4.4-enrique.test.rev.PNG)

## 4.5 Comprobación de las configuraciones

Comprobamos la configuración de la zona de resolución directa.

### Capturas de pantalla

**Comprobamos que todo esté correcto**

![named.conf.local](images/4.5-comprobaciones.PNG)

**Comprobación del estado**

![named.conf.local](images/4.5-comprobacion-estado.PNG)

## 4.6 - 5 - 6 Comprobación de las resoluciones y consultas

Verificar el correcto funcionamiento del servidor DNS configurado con BIND9, comprobando tanto la resolución directa (nombre → IP) como la inversa (IP → nombre).

### Capturas de pantalla

**Comprobación con resolución directa (`dig`)**

![named.conf.local](images/5-resolucion-directa.PNG)

**Comprobación con resolución inversa (`dig`)**

![named.conf.local](images/5-resolucion-inversa.PNG)

**Comprobación con `nslookup`**

![named.conf.local](images/6-nslookup.PNG)

# Práctica 2 - Configuración de un servidor FTP

## 1. Configuración de partida

Se ha actualizado la zona DNS enrique.test para añadir un alias FTP que apunta al servidor principal ns.enrique.test, con dirección IP 192.168.58.10.

### Verificación de la resolución DNS

Se comprobó la resolución del alias con el comando dig ftp.enrique.test @192.168.58.10

**Comprobación de la resolución del alias**

![named.conf.local](images/comprobar-alias.PNG)

## 1.1 Configuración DNS

En este punto se ha configurado la máquina ns.enrique.test como servidor DNS maestro, con autoridad sobre el dominio enrique.test y la zona inversa 58.168.192.in-addr.arpa
Además, se ha verificado la resolución de nombres tanto directa como inversa, asegurando que el servicio DNS funciona correctamente.

**Archivo resolv.conf y verificación dig**

![named.conf.local](images/resolv.PNG)

![named.conf.local](images/dig-ftp.PNG)

## 2. Uso del cliente FTP gráfico

En este punto utilicé FileZilla para conectarme a un servidor remoto y realizar operaciones de descarga y subida de archivos

### Pasos seguidos

-Instalación de FileZilla Client en el equipo anfitrión.
-Creación del directorio C:\Users\kigoi\Documents\pruebasFTP y del archivo datos1.txt.
-Conexión anónima al servidor público ftp.cica.es en el puerto 21.
-Descarga del archivo /pub/check al directorio local.
-Verificación de la correcta descarga.
-Intento de subida del archivo datos1.txt (rechazada por el servidor).
-Cierre de la conexión.

**Conexión al servidor, descarga y subida de archivos**

![named.conf.local](images/conexion-filezilla.PNG)

![named.conf.local](images/archivo-check.PNG)

![named.conf.local](images/permiso-denegado.PNG)

## 3. Instalación y configuración del servidor vsftpd sobre Linux

Hemos montado mi propio servidor FTP (vsftpd) dentro de la máquina

### Pasos seguidos

**Instalar el servidor vsftpd**

![named.conf.local](images/1-instalar-vsftpd.PNG)

**Comprobar el usuario y grupo FTP**

![named.conf.local](images/2-usuario-grupo.PNG)

**Verificar directorio y permisos**

![named.conf.local](images/3-permisos.PNG)

**Ver qué usuarios no pueden acceder por FTP**

![named.conf.local](images/4-usuarios-denegados.PNG)

**Verificar el servicio**

![named.conf.local](images/5-verificar-servicio.PNG)

**Verificar el puerto 21**

![named.conf.local](images/6-verificar-puerto.PNG)

**Copia de seguridad del archivo de configuración**

![named.conf.local](images/7-copia-seguridad.PNG)

**Crear usuarios locales**

![named.conf.local](images/8-usuarios.PNG)

**Crear archivos de prueba**

![named.conf.local](images/9-archivos-prueba.PNG)

**Configurar /etc/vsftpd.conf**

![named.conf.local](images/10-vsftpd.PNG)

**Comprobaciones**

![named.conf.local](images/11-comprobar.PNG)

**Conexión anonymous**

![named.conf.local](images/11.5-anonymous.PNG)

**Conexión maria**

![named.conf.local](images/12-maria.PNG)

**Conexión luis**

![named.conf.local](images/13-luis.PNG)

## 4. Configuración del servidor vsftpd seguro (FTPS)

Se ha configurado el servidor vsftpd para aceptar conexiones seguras mediante FTPS.  
Se ha generado un certificado autofirmado y se ha probado tanto el acceso de usuarios autenticados como anónimos.

**Generar el certificado TLS**

![named.conf.local](images/1-certificado.PNG)

**Configurar vsftpd para usar TLS**

![named.conf.local](images/2-tls.PNG)

**Comprobar el estado**

![named.conf.local](images/3-comprobar-estado.PNG)

**Probar conexión segura desde cliente**

![named.conf.local](images/4-certificado-aviso.PNG)

**Descargar archivo**

![named.conf.local](images/3.5-descargar-archivo.PNG)

**Probar conexión segura anónima**

![named.conf.local](images/5-anonymous-denegado.PNG)