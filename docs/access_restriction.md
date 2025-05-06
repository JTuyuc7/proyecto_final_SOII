# 🔐 Restricción de Acceso por Usuario

Este documento describe cómo configurar permisos adecuados para garantizar que cada usuario del servidor pueda acceder **únicamente** a los archivos y carpetas que le corresponden, implementando así el principio de privilegio mínimo.

## 📋 Objetivo

- Aislar los servicios para que cada usuario solo pueda acceder a sus propios recursos
- Prevenir acceso no autorizado a archivos y carpetas de otros servicios
- Mantener un entorno seguro y compartimentado

## 🛠️ Configuración de Permisos

### Cambiar el propietario de la carpeta de servicio

```bash
sudo chown -R <usuario>:<grupo> /opt/proyecto_so2/proyecto_final_SOII/services/<carpeta>
```

Ejemplo para el servicio FTP:
```bash
sudo chown -R ftpuser:docker /opt/proyecto_so2/proyecto_final_SOII/services/ftp
```

Este comando asigna la propiedad de la carpeta y todos sus contenidos al usuario `ftpuser` y al grupo `docker`.

### Limitar acceso exclusivamente al usuario

```bash
sudo chmod -R 700 /opt/proyecto_so2/proyecto_final_SOII/services/<carpeta>
```

Ejemplo para el servicio FTP:
```bash
sudo chmod -R 700 /opt/proyecto_so2/proyecto_final_SOII/services/ftp
```

El permiso `700` significa:
- `7` (rwx) - El propietario tiene permisos de lectura, escritura y ejecución
- `0` (---) - El grupo no tiene ningún permiso
- `0` (---) - Otros usuarios no tienen ningún permiso

## 🔄 Permisos para diferentes tipos de servicios

### Servicios web (Nginx, Python Web)

```bash
# Cambiar propietario
sudo chown -R webuser:docker /opt/proyecto_so2/proyecto_final_SOII/services/web

# Establecer permisos para directorios
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/web -type d -exec chmod 755 {} \;

# Establecer permisos para archivos
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/web -type f -exec chmod 644 {} \;
```

Estos permisos permiten:
- El propietario puede leer, escribir y ejecutar
- El grupo y otros usuarios pueden leer y ejecutar directorios, pero solo leer archivos

### Servicios de base de datos (PostgreSQL)

```bash
# Cambiar propietario
sudo chown -R dbuser:docker /opt/proyecto_so2/proyecto_final_SOII/services/db

# Establecer permisos más restrictivos
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/db -type d -exec chmod 750 {} \;
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/db -type f -exec chmod 640 {} \;
```

Estos permisos permiten:
- El propietario puede leer, escribir y ejecutar
- El grupo puede leer y ejecutar directorios, y leer archivos
- Otros usuarios no tienen ningún permiso

## 🔍 Verificación de permisos

Para verificar que los permisos se han aplicado correctamente:

```bash
# Verificar propietario y permisos
ls -la /opt/proyecto_so2/proyecto_final_SOII/services/

# Verificar permisos de forma recursiva
find /opt/proyecto_so2/proyecto_final_SOII/services/<carpeta> -type f -ls
```

## 📝 Buenas prácticas

1. **Principio de privilegio mínimo**: Asigna solo los permisos necesarios para que el servicio funcione correctamente
2. **Revisión periódica**: Verifica regularmente los permisos para asegurar que no se hayan modificado
3. **Documentación**: Mantén un registro de los permisos asignados a cada servicio
4. **Grupos**: Utiliza grupos para gestionar permisos de forma más eficiente cuando múltiples usuarios necesitan acceso similar

## 🔒 Consideraciones adicionales de seguridad

- Considera usar listas de control de acceso (ACL) para configuraciones de permisos más complejas
- Implementa monitoreo de acceso a archivos para detectar intentos de acceso no autorizado
- Configura auditoría de acceso a archivos sensibles
