# Como crear un usuario postgress en el droplet

En esta guia exploraremos la forma de agregar un nuevo usuario postgress, agregarlo al grupo de docker y darle los permisos necesarios para que pueda ejecutar unicamente lo que necesita.

### Crear un usuario.
Para crear un usuario espeficio para postgress
```bash
sudo adduser --shell /bin/bash postgresuser
```

nos pedira confirmar los detalles sobre, el nombre, grup etc... para esto podemos dejar los valores por defecto para qno tener que cambiarlos.

### Agregarlo al grupo de docker
Es importante que para que este usuario tenga acceso a ejecutar contenedores y servicios necesarios con docker, debemos agregarlo al grupo correspondiente.
```bash
sudo usermod -aG docker postgresuser
```
una vez agregado al grupo correspondiente, necesitamos restringirle los accesso al usuario para que no pueda acceder a otros recursos que no necesita
```bash
sudo chmod 700 /home/postgresuser
```
Listo, con esto deberiamos poder cambiarnos de usuario al usuario de postgres
```bash
su - postgresuser
```
ejecutar `docker ps` y veremos que tendremos acceso a poder ejecutar servicios de docker con ese usuario.

Estos pasos aplicaran para poder crear cualquier usuario y poder darle los permisos necesarios y que se encuentren aislados unos de otros y que solamente el usuario root pueda ver todos los procesos.

Teniendo esta configuracion hecha, podemos continuar con generar el servicio de la DB, para esto usaremos un `docker-compose.yml` file para que sea mucho mas rapido.

Para eso, tenemos definido dentro de la siguiente carpeta [postgres](../services/postgres) donde tendremos la configuracion necesaria para hacer lo sigueinte.
* Iniciar un contenedor postgres:15.
* Habilitar el puerto 6442.
* Crear una Base de datos, con una tabla (sencilla).
* Generar un volumen para no perder la informacion.

### Como saber si la conexion es exitosa
Para esto necesitaremos usar alguna herramienta como DBaver, pgslq, tableplus etc...
Necesitaremos los siguientes datos

* Host: TU_IP_DEL_DROPLET
* Puerto: 6432
* Usuario: remotereader
* Contraseña: tu_password_segura
* Base de datos: proyectos

Con esto deberiamos poder conectarnos fuera del droplet para tener acceso a la base de datos.