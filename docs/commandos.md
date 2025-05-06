# 🛠️ Comandos Útiles para Administración del Sistema

Este documento recopila comandos útiles para gestionar permisos, configurar servicios y administrar el sistema. Estos comandos son esenciales para el correcto funcionamiento de los diferentes servicios del proyecto.

## 📋 Índice
- [Gestión de Permisos](#gestión-de-permisos)
- [Configuración de Firewall](#configuración-de-firewall)
- [Gestión de Servicios](#gestión-de-servicios)
- [Monitoreo del Sistema](#monitoreo-del-sistema)

## 🔐 Gestión de Permisos

### Servicio Python Web

Para configurar los permisos adecuados para el servicio Python Web:

```bash
# Cambiar el propietario de la carpeta del servicio
sudo chown -R pythonuser:pythonuser /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb

# Establecer permisos adecuados para directorios
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb -type d -exec chmod 755 {} \;

# Establecer permisos adecuados para archivos
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb -type f -exec chmod 644 {} \;
```

Estos comandos realizan las siguientes acciones:
1. Asignan la propiedad de la carpeta del servicio al usuario `pythonuser`
2. Establecen permisos 755 (rwxr-xr-x) para todos los directorios
3. Establecen permisos 644 (rw-r--r--) para todos los archivos

### Servicio FTP

Para configurar los permisos adecuados para el servicio FTP:

```bash
# Cambiar el propietario de la carpeta del servicio
sudo chown -R ftpuser:docker /opt/proyecto_so2/proyecto_final_SOII/services/ftp

# Restringir acceso exclusivamente al usuario
sudo chmod -R 700 /opt/proyecto_so2/proyecto_final_SOII/services/ftp
```

Estos comandos realizan las siguientes acciones:
1. Asignan la propiedad de la carpeta del servicio al usuario `ftpuser` y al grupo `docker`
2. Establecen permisos 700 (rwx------) para restringir el acceso exclusivamente al propietario

### Servicio Nginx

```bash
# Cambiar el propietario de la carpeta del servicio
sudo chown -R nginxuser:docker /opt/proyecto_so2/proyecto_final_SOII/services/nginx

# Establecer permisos adecuados
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/nginx -type d -exec chmod 755 {} \;
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/nginx -type f -exec chmod 644 {} \;
```

### Servicio PostgreSQL

```bash
# Cambiar el propietario de la carpeta del servicio
sudo chown -R postgresuser:docker /opt/proyecto_so2/proyecto_final_SOII/services/postgres

# Establecer permisos adecuados
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/postgres -type d -exec chmod 750 {} \;
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/postgres -type f -exec chmod 640 {} \;
```

## 🔥 Configuración de Firewall

### Habilitar puertos para el servicio FTP

```bash
# Permitir el puerto SSH personalizado
sudo ufw allow 8022/tcp

# Permitir el rango de puertos para FTP pasivo
sudo ufw allow 21100:21110/tcp

# Recargar las reglas del firewall
sudo ufw reload
```

### Habilitar puertos para otros servicios

```bash
# Permitir el puerto para Nginx
sudo ufw allow 80/tcp

# Permitir el puerto para PostgreSQL
sudo ufw allow 6432/tcp

# Permitir el puerto para Python Web
sudo ufw allow 8080/tcp

# Recargar las reglas del firewall
sudo ufw reload
```

## 🔄 Gestión de Servicios

### Reiniciar servicios

```bash
# Reiniciar el servicio Nginx
docker restart nginx

# Reiniciar el servicio PostgreSQL
docker restart postgres

# Reiniciar el servicio Python Web
docker restart pythonweb

# Reiniciar el servicio FTP
docker restart ftp
```

## 📊 Monitoreo del Sistema

### Verificar el estado de los contenedores

```bash
# Listar todos los contenedores en ejecución
docker ps

# Verificar los logs de un contenedor específico
docker logs nginx
docker logs postgres
docker logs pythonweb
docker logs ftp
```

### Verificar el uso de recursos

```bash
# Verificar el uso de recursos de los contenedores
docker stats

# Verificar el espacio en disco
df -h

# Verificar el uso de memoria
free -m
```

## 📝 Notas Importantes

- Siempre verifica que los comandos se ejecuten correctamente antes de continuar
- Algunos comandos requieren privilegios de administrador (sudo)
- Asegúrate de adaptar los comandos a tu entorno específico si es necesario
- Realiza copias de seguridad antes de realizar cambios importantes en el sistema
