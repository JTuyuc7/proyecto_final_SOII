# 🌐 Configuración de logs para el servicio `nginx`

Este documento describe cómo redirigir los logs de Nginx a archivos persistentes accesibles desde el sistema, para monitoreo y diagnóstico.

---

## 📦 Requisitos previos

- Tener el contenedor `nginx` corriendo con Docker
- Tener acceso `root` en el servidor
- Carpeta del proyecto ubicada en `/opt/proyecto_so2/proyecto_final_SOII/services/nginx/`

---

## 🛠️ 1. Crear carpeta de logs y asignar permisos

```bash
sudo mkdir -p /var/log/proyecto_so2/nginx
sudo touch /var/log/proyecto_so2/nginx/access.log
sudo touch /var/log/proyecto_so2/nginx/error.log
sudo chown -R nginxuser:docker /var/log/proyecto_so2/nginx
sudo chmod -R 666 /var/log/proyecto_so2/nginx/*
```

## 🛠️ 2. Modificar el docker-compose.yml

Edita el archivo `docker-compose.yml` en la carpeta del servicio nginx para incluir los volúmenes de logs:

```bash
nano /opt/proyecto_so2/proyecto_final_SOII/services/nginx/docker-compose.yml
```

Agrega los siguientes volúmenes:

```yaml
volumes:
  - ./html:/usr/share/nginx/html
  - /var/log/proyecto_so2/nginx/access.log:/var/log/nginx/access.log
  - /var/log/proyecto_so2/nginx/error.log:/var/log/nginx/error.log
```

## 🛠️ 3. Reiniciar el contenedor

```bash
cd /opt/proyecto_so2/proyecto_final_SOII/services/nginx/
docker-compose down
docker-compose up -d
```

## 🛠️ 4. Verificar la configuración

Para comprobar que los logs se están escribiendo correctamente:

```bash
# Generar algo de tráfico
curl http://localhost:80

# Verificar los logs
tail -f /var/log/proyecto_so2/nginx/access.log
tail -f /var/log/proyecto_so2/nginx/error.log
```

## 🛠️ 5. Configurar rotación de logs (opcional)

Para evitar que los archivos de log crezcan indefinidamente, puedes configurar logrotate:

```bash
sudo nano /etc/logrotate.d/proyecto_nginx
```

Añade la siguiente configuración:

```
/var/log/proyecto_so2/nginx/*.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    create 0640 nginxuser docker
    sharedscripts
    postrotate
        [ -s /var/run/nginx.pid ] && kill -USR1 `cat /var/run/nginx.pid`
    endscript
}
```

## 📝 Notas adicionales

- Los logs de Nginx son esenciales para diagnosticar problemas y monitorear el tráfico.
- Asegúrate de revisar periódicamente los logs para detectar posibles problemas o intentos de intrusión.
- Considera implementar herramientas de análisis de logs como ELK Stack para un monitoreo más avanzado.
