# NGINX servicio
Primero necesitaremos crear el usuario correspondiente (crear usuario)[./user_creation.md]

una vez creado el usuario, neceitamos darle accesos a la carpeta que le corresponde. (restringir acceso)[docs/access_restriction.md]

Una vez creado el usuario, dado los permisos, simplemente necesitamos loguearnos con el usuario y ejecutar `docker compose up -d` esto iniciara el contenedor de docker para ejecutar nuesto servicio `nginx`, importante habilitar el puerto `80` para que pueda ser accesible desde afuera, (habilitar uwf)[./docs/enable_ufw.md]
