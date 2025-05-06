# 🛡️ Aislamiento de Procesos con `hidepid=2` en Linux

Este documento describe cómo configurar el sistema para restringir la visibilidad de procesos, evitando que usuarios no privilegiados puedan ver procesos de otros usuarios a través de comandos como `htop`, `ps`, o mediante el sistema de archivos `/proc`.

## 📋 Objetivo

Mejorar la seguridad del sistema implementando el aislamiento de procesos, lo que permite:

- Evitar que usuarios sin privilegios puedan ver procesos que no les pertenecen
- Reducir la exposición de información sensible del sistema
- Limitar la capacidad de reconocimiento en caso de compromiso de una cuenta de usuario
- Implementar el principio de privilegio mínimo

## 🔍 ¿Qué es `/proc`?

El sistema de archivos `/proc` es un sistema de archivos virtual que proporciona información sobre los procesos del sistema y otros componentes del kernel. Por defecto, cualquier usuario puede ver información sobre todos los procesos del sistema a través de `/proc`.

## 🛠️ Pasos para configurar `hidepid=2`

### 1. Verificar la configuración actual de `/proc`

Primero, verifica cómo está montado actualmente el sistema de archivos `/proc`:

```bash
mount | grep /proc
```

La salida debería ser similar a:

```
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
```

### 2. Editar el archivo de configuración

Edita el archivo `/etc/fstab` para modificar cómo se monta `/proc`:

```bash
sudo nano /etc/fstab
```

Agrega o modifica la línea correspondiente a `/proc`:

```
proc /proc proc defaults,hidepid=2 0 0
```

El parámetro `hidepid=2` tiene el siguiente efecto:
- `hidepid=0`: Comportamiento predeterminado, todos los usuarios pueden ver todos los procesos
- `hidepid=1`: Los usuarios solo pueden ver sus propios procesos, pero pueden ver la existencia de procesos de otros usuarios
- `hidepid=2`: Los usuarios solo pueden ver sus propios procesos y no pueden ver la existencia de procesos de otros usuarios

### 3. Aplicar los cambios sin reiniciar

Para aplicar los cambios inmediatamente sin necesidad de reiniciar el sistema:

```bash
sudo mount -o remount /proc
```

### 4. Verificar que los cambios se aplicaron correctamente

```bash
mount | grep /proc
```

La salida debería mostrar ahora el parámetro `hidepid=2`:

```
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime,hidepid=2)
```

## 🧪 Prueba de la configuración

### Como usuario normal

Inicia sesión como un usuario no privilegiado y ejecuta:

```bash
ps aux
```

Deberías ver solo los procesos que pertenecen a ese usuario.

### Como usuario root

Inicia sesión como root y ejecuta:

```bash
ps aux
```

Como root, seguirás viendo todos los procesos del sistema.

## 🔄 Comportamiento esperado

- Los usuarios no privilegiados solo verán sus propios procesos en `htop`, `ps`, etc.
- El usuario root seguirá viendo todos los procesos normalmente.
- No afecta la funcionalidad de Docker ni servicios del sistema.

## 📝 Consideraciones adicionales

### Permitir a ciertos grupos ver todos los procesos

Si necesitas que ciertos usuarios (como administradores del sistema) puedan ver todos los procesos sin ser root, puedes usar el parámetro `gid`:

```
proc /proc proc defaults,hidepid=2,gid=procadmins 0 0
```

Y luego crear un grupo `procadmins` y agregar a los usuarios que necesitan ver todos los procesos:

```bash
sudo groupadd procadmins
sudo usermod -aG procadmins usuario_admin
```

### Posibles problemas

Algunos programas pueden esperar ver todos los procesos y podrían no funcionar correctamente con `hidepid=2`. Si encuentras problemas con alguna aplicación, considera:

1. Agregar el usuario de la aplicación al grupo especial que puede ver todos los procesos
2. Usar `hidepid=1` en lugar de `hidepid=2` para un enfoque menos restrictivo

## 🔒 Mejoras de seguridad adicionales

Para una seguridad aún mayor, considera implementar:

1. **AppArmor o SELinux**: Para control de acceso obligatorio
2. **Restricciones de recursos con cgroups**: Para limitar los recursos que puede usar cada usuario
3. **Auditoría de sistema**: Para registrar actividades sospechosas
