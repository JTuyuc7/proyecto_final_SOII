# Habilitar UFW para exponer puertos.

Por defecto el droplet no expone ningun puerto, es decir que toda la comunicacion es interna entre el servidor, para poder habilitar puertos al exterior es importante definir las reglas, primero necesitamos habilitar UFW, es importante destacar que esto debemos ejecutarlo desde el usuario `root`

```bash
sudo ufw allow OpenSSH
```
Esto nos permitiar habilitar `ufw` sin cerrar la conexion `ssh` y pder seguir usando el puerto `22` para poder seguir interactuando con el droplet, una vez ejecutado el comando, necesitaremos ejecutar el siguiente
```bash
sudo ufw enable
```
Y para comprobar que si este funcioando podemos ejecutar este comando
```bash
sudo ufw status verbose
```
Si todo esta configurado correctamente deberiamos ver
```
Status: active

To                         Action      From
--                         ------      ----
22                         ALLOW       Anywhere
6432/tcp                   ALLOW       Anywhere
```

**Note** Si por alguna razón estás usando un puerto diferente para SSH (ej. 2222), debes permitir ese puerto antes de habilitar UFW, o podrías quedarte sin acceso.

### Habilitar puertos usando UWF
una vez habilitado podemos comenzar a abrir acceso a los puertos necesarios.
```bash
sudo ufw allow 6432/tcp # donde 6432 puede ser cualquier otro puerto que necesites.
```

```
To                         Action      From
--                         ------      ----
#... Otros puertos aca.
6432/tcp                   ALLOW       Anywhere
```