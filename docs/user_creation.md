# Crear un usuario desde root
En esta guia exploraremos la forma de agregar un nuevo usuario postgress, agregarlo al grupo de docker y darle los permisos necesarios para que pueda ejecutar unicamente lo que necesita.

### Crear un usuario.
Para crear un usuario espeficio para postgress
```bash
sudo adduser --shell /bin/bash postgresuser
```

nos pedira confirmar los detalles sobre, el nombre, grup etc... para esto podemos dejar los valores por defecto para qno tener que cambiarlos.

### Agregarlo al grupo de docker O cualquier otro
Es importante que para que este usuario tenga acceso a ejecutar contenedores y servicios necesarios con docker, debemos agregarlo al grupo correspondiente.
```bash
sudo usermod -aG docker postgresuser
```
una vez agregado al grupo correspondiente, necesitamos restringirle los accesso al usuario para que no pueda acceder a otros recursos que no necesita
```bash
sudo chmod 700 /home/postgresuser
```