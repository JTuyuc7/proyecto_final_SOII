# 🚀 Proyecto Final SO II

Este repositorio contiene la documentación y scripts necesarios para configurar y administrar un servidor Linux con múltiples servicios aislados utilizando Docker.

## 📋 Contenido

- [🚀 Proyecto Final SO II](#-proyecto-final-so-ii)
  - [📋 Contenido](#-contenido)
  - [🖥️ Requisitos del Sistema](#️-requisitos-del-sistema)
  - [🔧 Instalación y Configuración Inicial](#-instalación-y-configuración-inicial)
    - [Git](#git)
    - [Docker](#docker)
    - [SSH](#ssh)
  - [👥 Gestión de Usuarios y Permisos](#-gestión-de-usuarios-y-permisos)
    - [Usuarios](#usuarios)
    - [Grupos](#grupos)
    - [Restricción de Accesos](#restricción-de-accesos)
  - [🌐 Servicios Disponibles](#-servicios-disponibles)
    - [Nginx](#nginx)
    - [Python Web](#python-web)
    - [PostgreSQL](#postgresql)
    - [FTP](#ftp)
  - [🔐 Configuración de Seguridad](#-configuración-de-seguridad)
    - [Firewall (UFW)](#firewall-ufw)
    - [Aislamiento de Procesos](#aislamiento-de-procesos)
    - [Comandos Útiles](#comandos-útiles)
  - [📜 Scripts de Utilidad](#-scripts-de-utilidad)
  - [📝 Notas Adicionales](#-notas-adicionales)

## 🖥️ Requisitos del Sistema

- Servidor Linux (Ubuntu recomendado)
- Acceso root o privilegios sudo
- Conexión a Internet

## 🔧 Instalación y Configuración Inicial

### Git

Git es necesario para clonar este repositorio y mantener un control de versiones:

- [Instalación de Git](docs/Install_git.md)

### Docker

Docker se utiliza para aislar y gestionar los diferentes servicios:

- [Instalación de Docker](docs/docker_instalation.md)

### SSH

Configuración de acceso seguro al servidor:

- [Configuración de SSH](docs/ssh_creation.md)

## 👥 Gestión de Usuarios y Permisos

### Usuarios

- [Creación de Usuarios](docs/user_creation.md)

### Grupos

- [Creación y Gestión de Grupos](docs/group_creation.md)

### Restricción de Accesos

- [Restricción de Acceso por Usuario](docs/access_restriction.md)

## 🌐 Servicios Disponibles

### Nginx

- [Creación del Servicio Nginx](docs/create_nginx_service.md)
- [Configuración de Logs para Nginx](docs/nginx_logs.md)

### Python Web

- [Configuración de Logs para Python Web](docs/python_logs.md)

### PostgreSQL

- [Creación del Servicio PostgreSQL](docs/create_postgress_service.md)

### FTP

- Configuración disponible en `services/ftp/docker-compose.yml`

## 🔐 Configuración de Seguridad

### Firewall (UFW)

- [Habilitación y Configuración de UFW](docs/enable_ufw.md)

### Aislamiento de Procesos

- [Configuración de hidepid=2](docs/secure_proc_mount.md)

### Comandos Útiles

- [Comandos de Seguridad y Permisos](docs/commandos.md)

## 📜 Scripts de Utilidad

Los siguientes scripts automatizan tareas comunes:

- [Configuración de Nginx](scripts/nginx.sh)
- [Configuración de PostgreSQL](scripts/postgres.sh)
- [Configuración de Python Web](scripts/pythonweb.sh)
- [Configuración de FTP](scripts/ftp.sh)
- [Logs de Nginx](scripts/nginx_logs.sh)
- [Logs de Python](scripts/python_logs.sh)

## 📝 Notas Adicionales

Este proyecto está diseñado para proporcionar un entorno seguro y aislado para múltiples servicios en un único servidor. Cada servicio se ejecuta en su propio contenedor Docker y tiene acceso limitado a los recursos del sistema.

Para cualquier consulta o problema, por favor abra un issue en este repositorio.
