# 🐍 Configuración de logs para el servicio `pythonweb`

Este documento describe paso a paso cómo redirigir los logs del servidor Python (`http.server`) hacia un archivo persistente dentro del contenedor Docker y accesible desde el host.

---

## 📦 Requisitos previos

- Tener el contenedor `pythonweb` corriendo con Docker
- Tener acceso de superusuario (`root`) en el servidor
- Carpeta del proyecto ubicada en `/opt/proyecto_so2/proyecto_final_SOII/services/pythonweb/`

---

## 🛠️ 1. Crear carpeta de logs y asignar permisos

```bash
sudo mkdir -p /var/log/proyecto_so2/pythonweb
sudo touch /var/log/proyecto_so2/pythonweb/server.log
sudo chown -R pythonuser:docker /var/log/proyecto_so2/pythonweb
sudo chmod -R 666 /var/log/proyecto_so2/pythonweb/server.log
```

## 🛠️ 2. Crear script de inicio para Python con redirección de logs

Crea un archivo `start.sh` en la carpeta del servicio:

```bash
nano /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb/start.sh
```

Con el siguiente contenido:

```bash
#!/bin/bash
python -m http.server 8080 2>&1 | tee -a /logs/server.log
```

Asigna permisos de ejecución:

```bash
chmod +x /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb/start.sh
```

## 🛠️ 3. Modificar el docker-compose.yml

Edita el archivo `docker-compose.yml` para incluir el volumen de logs y usar el script de inicio:

```bash
nano /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb/docker-compose.yml
```

Asegúrate de que incluya:

```yaml
volumes:
  - ./:/app
  - /var/log/proyecto_so2/pythonweb:/logs

command: ["/app/start.sh"]
```

## 🛠️ 4. Reiniciar el contenedor

```bash
cd /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb/
docker-compose down
docker-compose up -d
```

## 🛠️ 5. Verificar la configuración

Para comprobar que los logs se están escribiendo correctamente:

```bash
# Generar algo de tráfico
curl http://localhost:8080

# Verificar los logs
tail -f /var/log/proyecto_so2/pythonweb/server.log
```

## 🛠️ 6. Configurar rotación de logs (opcional)

Para evitar que los archivos de log crezcan indefinidamente:

```bash
sudo nano /etc/logrotate.d/proyecto_pythonweb
```

Añade la siguiente configuración:

```
/var/log/proyecto_so2/pythonweb/*.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    create 0640 pythonuser docker
    sharedscripts
    postrotate
        docker restart pythonweb > /dev/null 2>&1 || true
    endscript
}
```

## 📝 Notas adicionales

- Los logs del servidor Python son útiles para depurar problemas y monitorear el acceso.
- Para una solución más robusta, considera usar un framework como Flask o Django que ofrecen mejores capacidades de logging.
- En entornos de producción, es recomendable usar un servidor WSGI como Gunicorn o uWSGI en lugar del servidor HTTP básico de Python.
