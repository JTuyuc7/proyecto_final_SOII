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

## Windows