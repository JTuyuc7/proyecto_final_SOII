# 🗄️ Creación de un servicio PostgreSQL en el servidor

Este documento describe los pasos necesarios para configurar y ejecutar un servicio PostgreSQL utilizando Docker.

## 📋 Requisitos previos

- Tener Docker instalado en el sistema
- Tener un usuario específico para el servicio PostgreSQL

## 🛠️ Pasos para la configuración

### 1. Iniciar sesión con el usuario de PostgreSQL

```bash
su - postgresuser
```

Verifica que el usuario tenga acceso a Docker ejecutando:

```bash
docker ps
```

### 2. Configurar el servicio de base de datos

El servicio PostgreSQL está definido en la carpeta [postgres](../services/postgres) donde encontrarás la configuración necesaria para:

* Iniciar un contenedor PostgreSQL 15
* Habilitar el puerto 6432
* Crear una base de datos con una tabla sencilla
* Generar un volumen para persistencia de datos

### 3. Iniciar el servicio

```bash
cd /opt/proyecto_so2/proyecto_final_SOII/services/postgres
docker-compose up -d
```

### 4. Verificar la conexión

Para verificar que la conexión es exitosa, necesitarás usar alguna herramienta como DBeaver, psql, TablePlus, etc.

Datos de conexión:
* Host: TU_IP_DEL_SERVIDOR
* Puerto: 6432
* Usuario: remotereader
* Contraseña: tu_password_segura
* Base de datos: proyectos

## 🔓 Habilitar el puerto en el firewall

Si no puedes conectarte desde el exterior, es necesario habilitar el puerto en el firewall:

```bash
# Ejecutar como usuario con privilegios sudo
sudo ufw allow 6432/tcp
```

### Verificar que el puerto está habilitado

```bash
sudo ufw status
```

Deberías ver algo como:

```
6432/tcp                  ALLOW       Anywhere
```

Si no ves esta regla, es necesario habilitar UFW. Consulta la [guía de habilitación de UFW](./enable_ufw.md).

## 📝 Notas adicionales

- Los datos de la base de datos se almacenan en un volumen de Docker para garantizar su persistencia.
- Es recomendable realizar copias de seguridad periódicas de la base de datos.
- Para mayor seguridad, considera limitar el acceso al puerto 6432 solo a IPs específicas.

## 🔍 Solución de problemas

Si encuentras problemas al conectarte a la base de datos:

1. Verifica que el contenedor esté en ejecución: `docker ps | grep postgres`
2. Comprueba los logs del contenedor: `docker logs postgres`
3. Asegúrate de que el puerto 6432 esté habilitado en el firewall
4. Verifica que estás usando las credenciales correctas
