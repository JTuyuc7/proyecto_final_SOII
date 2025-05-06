#!/bin/bash

# Ruta para los logs del servicio Python
LOG_DIR="/var/log/proyecto_so2/pythonweb"

echo "🛠️ Creando carpeta de logs para PythonWeb en $LOG_DIR"
sudo mkdir -p "$LOG_DIR"
sudo touch "$LOG_DIR/server.log"

echo "🔒 Asignando permisos a pythonuser:docker"
sudo chown -R pythonuser:docker "$LOG_DIR"
sudo chmod -R 664 "$LOG_DIR"/*

echo "✅ Logs para Python listos en:"
ls -l "$LOG_DIR"
