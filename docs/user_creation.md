# 👤 Creación y Configuración de Usuarios

Este documento describe los pasos necesarios para crear y configurar usuarios en el sistema, asignarles permisos adecuados y restringir su acceso a los recursos que necesitan.

## 🛠️ Creación de un nuevo usuario

### 1. Crear un usuario con shell bash

```bash
sudo adduser --shell /bin/bash postgresuser
```

Este comando crea un nuevo usuario llamado `postgresuser` con el shell bash como intérprete de comandos predeterminado. Durante el proceso, se te pedirá:

- Establecer una contraseña para el usuario
- Proporcionar información adicional (nombre completo, número de teléfono, etc.)

Puedes dejar los valores adicionales en blanco presionando Enter para cada uno.

> **Nota**: Reemplaza `postgresuser` con el nombre que desees para el usuario.

### 2. Verificar que el usuario se creó correctamente

```bash
id postgresuser
```

Este comando mostrará información sobre el usuario, incluyendo su ID, grupo primario y grupos secundarios.

## 👥 Asignación de grupos

### Agregar el usuario al grupo de Docker

Para que el usuario pueda ejecutar comandos de Docker sin necesidad de usar `sudo`:

```bash
sudo usermod -aG docker postgresuser
```

### Agregar el usuario a otros grupos

Si necesitas agregar el usuario a múltiples grupos:

```bash
sudo usermod -aG grupo1,grupo2,grupo3 postgresuser
```

## 🔐 Restricción de acceso

### Limitar el acceso al directorio home del usuario

Para restringir el acceso al directorio home del usuario, de modo que solo él pueda acceder:

```bash
sudo chmod 700 /home/postgresuser
```

Este comando establece los siguientes permisos:
- El propietario (postgresuser) tiene permisos de lectura, escritura y ejecución
- El grupo y otros usuarios no tienen ningún permiso

## 🔑 Configuración de acceso SSH

### Permitir acceso SSH al usuario

Si deseas permitir que el usuario acceda al servidor mediante SSH:

1. Asegúrate de que el usuario esté en el grupo `ssh` o `sshusers` (si existe):
   ```bash
   sudo usermod -aG ssh postgresuser
   ```

2. Configura la autenticación por clave SSH siguiendo las instrucciones en [Configuración de SSH](./ssh_creation.md).

## 🛡️ Restricción de comandos

### Limitar los comandos que puede ejecutar el usuario

Para limitar los comandos que el usuario puede ejecutar con `sudo`, edita el archivo sudoers:

```bash
sudo visudo
```

Agrega una línea como la siguiente:

```
postgresuser ALL=(ALL) /bin/systemctl restart postgresql, /bin/systemctl status postgresql
```

Esto permitirá al usuario ejecutar solo los comandos especificados con `sudo`.

## 📝 Buenas prácticas

1. Utiliza contraseñas fuertes y únicas para cada usuario
2. Aplica el principio de privilegio mínimo: asigna solo los permisos necesarios
3. Revisa periódicamente los usuarios del sistema y sus permisos
4. Configura la caducidad de contraseñas para usuarios críticos:
   ```bash
   sudo chage -M 90 postgresuser  # La contraseña caduca cada 90 días
   ```
5. Documenta los usuarios creados, sus propósitos y permisos
