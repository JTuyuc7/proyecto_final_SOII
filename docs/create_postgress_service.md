# Como crear un usuario postgress en el droplet

Debemos cambiarnos de usuario al usuario de postgres
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

Si en dado caso no nos podamos conectar, es necesario habilitar el puerto en el droplet para que podamos tener acceso.

### Como habilitar el puerto.
Para ejecutar este comando, se debe contar con permisos de administrador (sudo)
```bash
sudo ufw allow 6432/tcp
```
### Verificar el puerto habilitado
```bash
sudo ufw status
```
Si vemos algo asi
```bash
6432/tcp                  ALLOW       Anywhere
```

Si por algun motivo no vemos eso, es necesario habilitar las reglas UFW para que funcione (habilitar UFW)[./docs/enable_ufw.md]


