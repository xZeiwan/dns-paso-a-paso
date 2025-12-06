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

# Práctica 2.1.1 — Instalación y configuración del servidor web Nginx

## 1. Introducción

Todas las configuraciones del servidor web utilizarán el dominio enrique.test

## 2. Instalación del servidor web Nginx

Primero actualizamos los repositorios del sistema con sudo apt update

Para instalar el servidor web Nginx (versión usada en esta práctica: 1.18.0), usamos sudo apt install nginx -y

**Comprobar que está instalado, activo y funcionando:**

![named.conf.local](images/2-verificar-nginx.png)

## 3. Creación de las carpetas del sitio web

Para alojar el contenido del dominio `enrique.test`, se creó la estructura estándar dentro de `/var/www`:

bash
sudo mkdir -p /var/www/enrique.test/html

A continuación, se clonó el sitio web de ejemplo dentro de la carpeta html:
sudo chown -R www-data:www-data /var/www/enrique.test/html
sudo chmod -R 755 /var/www/enrique.test

Finalmente, se accedió desde el navegador con http://192.168.58.10:

![named.conf.local](images/3-welcome-nginx.png)

## 4. Configuración del servidor web Nginx para el dominio `enrique.test`

## 4.1 Crear el archivo de configuración del sitio web

Para servir nuestro sitio web personalizado, creamos un bloque de servidor dentro de
`/etc/nginx/sites-available`:
sudo nano /etc/nginx/sites-available/enrique.test

**Archivo sites-avaible**

![named.conf.local](images/4.1-sites-available.png)

## 4.2 Crear el enlace simbólico en sites-enabled

Esto habilita el sitio: sudo ln -s /etc/nginx/sites-available/enrique.test /etc/nginx/sites-enabled/

Se puede comprobar con: ls -l /etc/nginx/sites-enabled/

**Enlace simbólico creado**

![named.conf.local](images/4.2-enlace-simbolico.png)

## 4.3 Comprobar que no hay errores en Nginx

Comprobamos que no hay errores:

**Comprobación errores**

![named.conf.local](images/4.3-verificar-nginx.png)

## 4.4 Reiniciar Nginx

sudo systemctl restart nginx
sudo systemctl status nginx

**Foto de reinicio**

![named.conf.local](images/4.4-reiniciar-nginx.png)

## 4.5 Comprobación con DNS o /etc/hosts

Lo que hice fue Editar el archivo hosts y añadir: 
192.168.58.10    enrique.test

**Comprobar funcionamiento**

![named.conf.local](images/4.5-comprobar-dns.png)

## 4.6 Comprobar los logs

Acceso log: sudo tail -n 20 /var/log/nginx/access.log

Errores: sudo tail -n 20 /var/log/nginx/error.log

**Acceso y errores**

![named.conf.local](images/4.6-comprobar-logs.png)

# Práctica 2.1.2: Instalación y configuración de servidor web Nginx con Docker

## 3. Creación de la estructura de carpetas del sitio web (Docker)

En la máquina anfitriona se preparó la estructura de directorios para alojar el contenido del sitio web `enrique.test` y la configuración personalizada de Nginx:

mkdir -p ~/nginx/enrique.test/html
mkdir -p ~/nginx/enrique.test/conf

**Estructura y clonación de repositorio**

![named.conf.local](images/nginxDocker/3-creacion-estructura.PNG)

## 4.1 Configuración de servidor web NGINX con Docker

Se creó la configuración personalizada de Nginx en el archivo:

**Archivo nginx.conf**

![named.conf.local](images/nginxDocker/4.1-nginx.conf.PNG)

## 4.2. Crear y ejecutar el contenedor Docker

Creamos un contenedor Docker que ejecute Nginx:

docker run -d \
  --name nginx-example \
  -p 80:80 \
  -v ~/nginx/example.test/html:/usr/share/nginx/html \
  -v ~/nginx/example.test/conf/nginx.conf:/etc/nginx/conf.d/default.conf \
  nginx:latest

**Ejecutar el contenedor Docker**

![named.conf.local](images/nginxDocker/4.2-contenedor-docker.PNG)

**Confirmar que el contenedor está corriendo**

![named.conf.local](images/nginxDocker/4.2-comprobar.PNG)

**Ver logs del contenedor**

![named.conf.local](images/nginxDocker/4.2-logs.PNG)

## 5. Comprobación del funcionamiento

Para comprobar que el servidor está funcionando y sirviendo páginas correctamente, accedemos al cliente con http://localhost

**Comprobar funcionamiento**

![named.conf.local](images/nginxDocker/5-welcome.PNG)

## 5.1.1 Editar archivo hosts

El objetivo es asociar 127.0.0.1 con el dominio enrique.test para que el navegador sepa a dónde enviar las peticiones.
Hay que añadir nuestra entrada de dominio al archivo hosts:

**Añadir entrada**

![named.conf.local](images/nginxDocker/5.1.1-hosts.PNG)

**Comprobar funcionamiento**

![named.conf.local](images/nginxDocker/5.1.1-comprobar.PNG)

## 5.2. Comprobar registros del servidor

Comprobamos los logs con el comando docker: docker logs -f nginx-example

**Logs en tiempo real**

![named.conf.local](images/nginxDocker/5.2-logs-servidor.PNG)

## 6. Gestión del contenedor Docker

Para administrar el contenedor Docker que ejecuta Nginx se utilizan varios comandos básicos:
Para detener el contenedor utilizamos docker stop nginx-enrique, lo que detiene su ejecución sin borrarlo.
Si necesitamos reiniciarlo, ya sea para volver a ponerlo en marcha o para aplicar cambios en la configuración, usamos docker restart nginx-enrique.

Cuando es necesario modificar el servidor web, simplemente editamos el archivo ~/nginx/enrique.test/conf/nginx.conf desde la máquina anfitriona y reiniciamos el contenedor para que cargue los cambios.
Finalmente, si el contenedor ya no es necesario, podemos eliminarlo completamente ejecutando docker stop nginx-enrique seguido de docker rm nginx-enrique.

**Gestión comandos**

![named.conf.local](images/nginxDocker/6-gestion-contenedor.PNG)

## 7. Alternativa: Uso de Docker Compose

Como alternativa al uso directo del comando docker run, se puede utilizar Docker Compose para definir y gestionar el contenedor de Nginx mediante un archivo declarativo.
En la máquina anfitriona se creó el archivo docker-compose.yml dentro del directorio del proyecto con la siguiente configuración:

**Configuración docker-compose.yml**

![named.conf.local](images/nginxDocker/7-docker-compose.PNG)

Docker Compose monta las carpetas locales en el contenedor, mapea el puerto 80 y aplica automáticamente la configuración del servidor web.

Los logs se visualizan mediante docker-compose logs -f, y para detener y eliminar los contenedores creados por la composición se usa docker-compose down:

**Ver y eliminar logs**

![named.conf.local](images/nginxDocker/7-logs.PNG)

# Práctica 2.2: Autenticación en Nginx con Docker

## 1.1 Paquetes necesarios

Para generar contraseñas cifradas se utilizó la imagen stakater/ssl-certs-generator, descargada con:
docker pull stakater/ssl-certs-generator

**Imagen de descarga**

![named.conf.local](images/2.2-nginx-docker/1.1-instalacion.JPG)

## 1.2. Creación de usuarios y contraseñas para el acceso web

Para habilitar autenticación básica en Nginx se creó un archivo htpasswd dentro de la estructura del sitio.

Tras la generación de los hashes, el archivo quedó de la siguiente forma:

![named.conf.local](images/2.2-nginx-docker/1.2-clave.JPG)

## 1.3. Configurando el contenedor Nginx para usar autenticación básica

En este apartado se ha configurado el servidor Nginx (que se ejecutará en Docker) para proteger el acceso a la página web mediante autenticación HTTP Basic. He usado Git Bash.

**Edición del archivo de configuración**

![named.conf.local](images/2.2-nginx-docker/1.3-conf.JPG)

**Montaje del archivo de configuración y del htpasswd dentro del contenedor**

![named.conf.local](images/2.2-nginx-docker/1.3-nuevo-contenedor.JPG)

## 1.4. Probando la nueva configuración

Desde el navegador se accedió a http://enrique.test:8080/

El navegador muestra un cuadro de autenticación solicitando usuario y contraseña.

**Formulario login**

![named.conf.local](images/2.2-nginx-docker/1.4-login.JPG)

**Acceso permitido**

![named.conf.local](images/2.2-nginx-docker/1.4-login-exito.JPG)

## 2. Tareas

## 2.1 T.1. Análisis de Logs

Se intentó acceder primero con un usuario erróneo (marta) y luego con el usuario correcto (enrique).

Se ha utilizado el comando docker logs nginx-enrique para visualizar los registros.

¿Dónde podemos ver los errores de usuario inválido o no encontrado? Se visualizan en el log de errores (error.log). En la captura se observa la línea: [error] ... user "marta" was not found in "/etc/nginx/.htpasswd"

¿Dónde podemos ver el número de error que os aparecía antes? Se visualiza en el log de acceso (access.log). Al cancelar la autenticación o fallar el usuario, el servidor registra el código de estado HTTP 401 (Unauthorized). En la captura se observa: "GET / HTTP/1.1" 401

**Intento de acceso con marta**

![named.conf.local](images/2.2-nginx-docker/2.1-intento-login-marta.JPG)

**Intento de acceso con enrique**

![named.conf.local](images/2.2-nginx-docker/2.1-intento-login-enrique.JPG)

## 2.2 T2: Autenticación específica en /contact.html

Se modificó la configuración de Nginx para eliminar la autenticación del directorio raíz y aplicarla únicamente a la sección `contact.html`.

**Modificación de enrique.test.conf**
Se editaron las directivas de ubicación (`location`) en el archivo de configuración:

![named.conf.local](images/2.2-nginx-docker/2.2-contacto.JPG)

**Comprobaciones**

Acceso a la raíz (/): El navegador muestra la página de inicio sin solicitar credenciales, permitiendo el acceso público.

![named.conf.local](images/2.2-nginx-docker/2.2-entrada-sin-clave.JPG)

Acceso a /contact.html: Al intentar acceder a esta sección específica, el navegador solicita usuario y contraseña.

![named.conf.local](images/2.2-nginx-docker/2.2-entrada-con-clave.JPG)

![named.conf.local](images/2.2-nginx-docker/2.2-contacto.JPG)

## 2.3 T2: Combinación de autenticación básica y restricción de IP
Se configuró Nginx para que, desde la máquina anfitriona, sea obligatorio cumplir dos condiciones simultáneamente para acceder al directorio raíz: tener una IP permitida y autenticarse con usuario y contraseña.

Se utilizó la directiva satisfy all para combinar la restricción de IP (allow 172.17.0.1) con la autenticación básica (auth_basic)

![named.conf.local](images/2.2-nginx-docker/2.3-conf.JPG)

Comprobaciones

Acceso desde IP permitida: Al acceder desde la IP autorizada (172.17.0.1), Nginx valida la primera condición y solicita las credenciales para cumplir la segunda.

![named.conf.local](images/2.2-nginx-docker/2.3-error.JPG)

![named.conf.local](images/2.2-nginx-docker/2.3-error1.JPG)

## 3.1 T1: Denegación de acceso a la IP anfitriona
Se configuró Nginx para prohibir explícitamente el acceso desde la dirección IP de la máquina anfitriona (172.17.0.1) al directorio raíz del sitio web.
Se utilizó la directiva deny para la IP detectada en los logs:

![named.conf.local](images/2.2-nginx-docker/3.1-conf.JPG)

Página de error: Al intentar acceder desde el navegador, el servidor responde con un error 403 Forbidden.

![named.conf.local](images/2.2-nginx-docker/3.1-error.JPG)

## 3.2 T2: Exigencia simultánea de IP y Usuario válido
Se configuró el servidor para aplicar una política de seguridad estricta mediante la directiva satisfy all. Esto obliga al cliente a cumplir dos condiciones simultáneamente: conectarse desde una IP autorizada (172.17.0.1) y autenticarse con un usuario válido.
Se combinaron las directivas allow/deny con auth_basic bajo la regla satisfy all:

![named.conf.local](images/2.2-nginx-docker/3.2-conf.JPG)

Al acceder desde la máquina anfitriona (IP válida), el servidor solicita credenciales. Al introducir el usuario y contraseña correctos, se permite el acceso al sitio.

![named.conf.local](images/2.2-nginx-docker/3.2-acceso.JPG)

![named.conf.local](images/2.2-nginx-docker/3.2-acceso-index.JPG)

# Práctica 2.2: Autenticación en Nginx
Se configuró el servidor Nginx en la máquina virtual para restringir el acceso al sitio web enrique.test mediante autenticación básica.

## 1.2 Creación de credenciales
Se utilizó la herramienta openssl para generar las contraseñas cifradas y almacenarlas en el fichero /etc/nginx/.htpasswd.

![named.conf.local](images/2.2-nginx/1.1-paquetes.JPG)

Contenido del fichero generado:

![named.conf.local](images/2.2-nginx/1.2-clave.JPG)

## 1.3 Configuración de Nginx para autenticación básica
Se editó el archivo de configuración del sitio /etc/nginx/sites-available/enrique.test para proteger el directorio raíz.

![named.conf.local](images/2.2-nginx/1.3-conf.JPG)

Se reinició Nginx para cargar la nueva configuración:

![named.conf.local](images/2.2-nginx/1.3-reinicio.JPG)

¡Estupendo! Ya tienes el servidor funcionando como un reloj: pide contraseña y muestra tu web correcta.

Aquí tienes la documentación del punto 1.4, redactada para que encaje con tus capturas (Login + Web funcionando).

## 1.4 Probando la nueva configuración
Una vez reiniciado el servicio Nginx, se realizaron las comprobaciones de acceso desde el navegador del equipo anfitrión para verificar tanto la seguridad como el correcto despliegue del sitio web.

Al acceder a http://enrique.test, el servidor interrumpe la carga y solicita credenciales de acceso mediante una ventana emergente, confirmando que la directiva auth_basic está activa.

![named.conf.local](images/2.2-nginx/1.4-login.JPG)

El servidor autoriza la conexión y sirve correctamente el archivo index.html ubicado en /var/www/enrique.test/html.

![named.conf.local](images/2.2-nginx/1.4-login-correcto.JPG)

## 2.1 T1: Comprobación de logs de autenticación
Se realizaron pruebas de acceso con usuarios inválidos y válidos para verificar cómo Nginx registra estos eventos en sus archivos de log.

Pruebas realizadas:

Intento de acceso con usuario inexistente (pepe) y cancelación del login.

![named.conf.local](images/2.2-nginx/2.1-error.JPG)

![named.conf.local](images/2.2-nginx/2.1-error1.JPG)

Intento de acceso con usuario válido (enrique).

![named.conf.local](images/2.2-nginx/2.1-exito1.JPG)

![named.conf.local](images/2.2-nginx/2.1-exito.JPG)

## 2.2 T2: Autenticación específica en /contact.html
Se modificó la configuración de Nginx para eliminar la autenticación del directorio raíz y aplicarla únicamente a la sección contact.html, permitiendo que el resto del sitio web sea público.

Se editaron las directivas de ubicación (location) en el archivo de configuración para proteger solo el recurso específico:

![named.conf.local](images/2.2-nginx/2.2-conf.JPG)

Acceso a la raíz (/): El navegador muestra la página de inicio sin solicitar credenciales, permitiendo el acceso público.

![named.conf.local](images/2.2-nginx/2.2-acceso.JPG)

Acceso a /contact.html: Al intentar acceder a la sección de contacto, el navegador solicita usuario y contraseña.

![named.conf.local](images/2.2-nginx/2.2-acceso-contact.JPG)

Tras autenticarse correctamente, se permite el acceso a la página de contacto.

![named.conf.local](images/2.2-nginx/2.2-acceso-contact1.JPG)

## 2.3 Combinación de la autenticación básica con la restricción de acceso por IP
Se configuró el servidor Nginx para aumentar la seguridad exigiendo el cumplimiento de dos condiciones simultáneas para acceder al directorio raíz.

Se editó el archivo del sitio web /etc/nginx/sites-available/enrique.test. Dentro del bloque location /, se utilizó la directiva satisfy all. Esto obliga a que el cliente satisfaga tanto las reglas de control de acceso (allow/deny) como las de autenticación (auth_basic).

![named.conf.local](images/2.2-nginx/2.3-conf.JPG)

Comprobaciones:
Al acceder desde la máquina anfitriona (cuya IP 192.168.58.1 está permitida), Nginx valida la primera condición y procede a solicitar la segunda: el usuario y la contraseña.

![named.conf.local](images/2.2-nginx/2.3-acceso.JPG)

Tras introducir las credenciales correctas, el acceso al sitio web es concedido.

![named.conf.local](images/2.2-nginx/2.3-acceso1.JPG)

## 3.1 T1: Denegación de acceso a la IP anfitriona
Se configuró Nginx en la máquina virtual para denegar explícitamente el acceso desde la dirección IP de la máquina anfitriona (192.168.58.1) al directorio raíz del sitio web.

![named.conf.local](images/2.2-nginx/3.1-conf.JPG)

Al intentar acceder al sitio desde el navegador del anfitrión, el servidor deniega el acceso mostrando el error 403 Forbidden.

![named.conf.local](images/2.2-nginx/3.1-error.JPG)

Se verificó el archivo /var/log/nginx/error.log, donde se registra el bloqueo con el mensaje access forbidden by rule

![named.conf.local](images/2.2-nginx/3.1-error-log.JPG)

## 3.2 T2: Exigencia simultánea de IP y Usuario válido
Se configuró el servidor utilizando la directiva satisfy all. Esta configuración obliga a que el cliente cumpla dos condiciones simultáneamente para acceder: conectarse desde una IP autorizada y autenticarse con un usuario válido.

![named.conf.local](images/2.2-nginx/3.2-conf.JPG)

Al acceder desde la máquina anfitriona (cuya IP es válida), el servidor solicita credenciales. Tras introducir el usuario y contraseña correctos, se permite el acceso al contenido del sitio sin problemas.

![named.conf.local](images/2.2-nginx/3.2-acceso.JPG)

![named.conf.local](images/2.2-nginx/3.2-acceso1.JPG)
