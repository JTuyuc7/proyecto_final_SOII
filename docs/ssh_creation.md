# Creacion de una SSH para conectarse al droplet de DigitalOcean.

En esta guia mostraremos los pasos para poder crear una SSH key localmente en nuestra maquina y atravez de esta poder conectarnos a nuestro droplet.

## Mac
### Generar la SSH key

```bash
ssh-keygen
```
Esta nos generara un clave, y nos preguntara el nombre y la ubicacion donde queremos que esta se guarde, por defecto la creara en la siguiente ubicacion
```dotnetcli
/Users/<tu_user>/.ssh/id_ed25519
```
es recomendable poder darle un nombre unico para poder distinguirla, en el caso de tener mas claves generadas, esto se puede hacer, una vez que en la terminal nos pregunte.
```bash
/Users/<tu_user>/.ssh/id_ed25519_digitalocean
```
esto nos generara tanto la clave privada como la clave publica que es la que usaremos en digital ocean.

si la ubicacion que se elijio es la por defecto, esta debe estar guardada en 
```bash
/Users/<tu_user>/.ssh
```
en esta ubicacion estara guardada tanto la clave privada como la publica, esto garantizara una conexion segura entre tu maquina y tu servidor, el contenido que tendras que copiar para realizar la conexion sera la que tenga la clave publica
```bash
id_ed25519_digitalocean.pub
``` 

**Nota** importante recordar que el contenido de estos archivo es sensible.

### Configurar la ssh
Para esta configuracion que hemos realizado la conexion a nuestro droplet es mediante la clave ssh que generamos, sin embargo el comando para poder conectarnos es complicado y dificil de recordar.
```bash
ssh -i ~/.ssh/id_ed25519_digitalocean root@IP_DEL_DROPLET
```
y tener que recordar eso siempre puede ser complicado, para poder solucionar este problema podemos editar el archivo de configuraciones `config` ubicado en 
```bash
/Users/<tu_user>/.ssh
```
y agregar la siguiente configuracion
```bash
Host digitalocean-server # o el nombre que quieras
     HostName IP_DEL_DROPLET
     User root
     IdentityFile ~/.ssh/id_ed25519_digitalocean_server # O el nombre que le hayas dado
```
esto nos permitira conectarnos de la siguiente forma.
```bash
ssh digitalocean-server
```
que es mucho mas sencillo de recordar, nos pedira que se agregue la ip de configuracion a los hosts de nuestra maquina, para que se pueda establecer la conexion.


## Windows