# 👥 Creación y Gestión de Grupos

Este documento describe los pasos necesarios para crear y gestionar grupos de usuarios en el sistema, lo que permitirá un mejor control sobre qué usuarios tendrán acceso a determinadas carpetas y recursos.

## 📋 ¿Por qué usar grupos?

Los grupos en Linux permiten:
- Organizar usuarios con necesidades similares
- Asignar permisos a múltiples usuarios a la vez
- Centralizar la gestión de accesos a recursos compartidos
- Implementar el principio de privilegio mínimo

## 🛠️ Creación de un nuevo grupo

### 1. Crear el grupo

```bash
sudo groupadd devteam
```

Este comando crea un nuevo grupo llamado `devteam`. Puedes reemplazar `devteam` con el nombre que desees para tu grupo.

### 2. Verificar que el grupo se creó correctamente

```bash
getent group devteam
```

Este comando mostrará información sobre el grupo si se creó correctamente. La salida debería ser similar a:

```
devteam:x:1001:
```

## 👤 Gestión de usuarios en el grupo

### Agregar un usuario a un grupo

```bash
sudo usermod -aG devteam postgresuser
```

Este comando agrega el usuario `postgresuser` al grupo `devteam`. Puedes reemplazar estos nombres con los usuarios y grupos correspondientes en tu sistema.

> **Nota**: La opción `-a` significa "append" (añadir) y es importante incluirla junto con `-G` para evitar eliminar al usuario de otros grupos a los que ya pertenece.

### Verificar los grupos de un usuario

```bash
groups postgresuser
```

Este comando mostrará todos los grupos a los que pertenece el usuario `postgresuser`. La salida debería incluir el grupo `devteam` si el usuario fue agregado correctamente.

## 🔐 Asignar permisos a nivel de grupo

Una vez creado el grupo y agregados los usuarios, puedes asignar permisos a nivel de grupo a directorios o archivos:

```bash
# Cambiar el grupo propietario de un directorio
sudo chown :devteam /ruta/al/directorio

# Establecer permisos para el grupo
sudo chmod g+rwx /ruta/al/directorio
```

## 🔄 Cambiar el grupo primario de un usuario

Si deseas cambiar el grupo primario de un usuario (el grupo que se asigna por defecto a los archivos creados por ese usuario):

```bash
sudo usermod -g devteam postgresuser
```

> **Nota**: A diferencia de `-G` (que gestiona grupos secundarios), `-g` cambia el grupo primario del usuario.

## 🗑️ Eliminar un grupo

Si necesitas eliminar un grupo que ya no se utiliza:

```bash
sudo groupdel devteam
```

> **Advertencia**: Antes de eliminar un grupo, asegúrate de que ningún archivo o directorio lo tenga como propietario, ya que esto podría causar problemas de acceso.

## 📝 Buenas prácticas

1. Utiliza nombres descriptivos para los grupos que indiquen su propósito
2. Revisa periódicamente la membresía de los grupos para mantener la seguridad
3. Aplica el principio de privilegio mínimo: asigna solo los permisos necesarios
4. Documenta la estructura de grupos y sus propósitos para facilitar la administración
