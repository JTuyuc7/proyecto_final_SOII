# 🌐 Servicio NGINX

Este documento describe los pasos necesarios para configurar y ejecutar un servicio NGINX utilizando Docker.

## 📋 Requisitos previos

- Tener Docker instalado en el sistema
- Tener un usuario específico para el servicio NGINX

## 🛠️ Pasos para la configuración

### 1. Crear el usuario correspondiente

Primero, necesitamos crear un usuario específico para el servicio NGINX. Sigue las instrucciones en la [guía de creación de usuarios](./user_creation.md).

### 2. Asignar permisos al usuario

Una vez creado el usuario, necesitamos darle acceso a la carpeta que le corresponde. Sigue las instrucciones en la [guía de restricción de acceso](./access_restriction.md).

### 3. Iniciar el servicio

Una vez creado el usuario y asignados los permisos, simplemente necesitamos iniciar el servicio:

```bash
# Iniciar sesión con el usuario de NGINX
su - nginxuser

# Navegar a la carpeta del servicio
cd /opt/proyecto_so2/proyecto_final_SOII/services/nginx

# Iniciar el contenedor
docker compose up -d
```

### 4. Habilitar el puerto

Es importante habilitar el puerto `80` para que el servicio sea accesible desde el exterior. Sigue las instrucciones en la [guía de habilitación de UFW](./enable_ufw.md).

```bash
# Ejecutar como usuario con privilegios sudo
sudo ufw allow 80/tcp
sudo ufw reload
```

## 📝 Verificación del servicio

Para verificar que el servicio está funcionando correctamente:

```bash
# Verificar que el contenedor está en ejecución
docker ps | grep nginx

# Probar el acceso al servicio
curl http://localhost:80
```

## 🔍 Solución de problemas

Si el servicio no está funcionando correctamente, verifica:

1. Que el usuario tiene los permisos adecuados
2. Que el puerto 80 está habilitado en el firewall
3. Que el contenedor está en ejecución
4. Los logs del contenedor para identificar posibles errores:
   ```bash
   docker logs nginx
   ```

## 📚 Recursos adicionales

- [Configuración de logs para NGINX](./nginx_logs.md)
- [Documentación oficial de NGINX](https://nginx.org/en/docs/)
