#!/bin/bash

# Ruta para los logs de Nginx
LOG_DIR="/var/log/proyecto_so2/nginx"

echo "🛠️ Creando carpeta de logs para Nginx en $LOG_DIR"
sudo mkdir -p "$LOG_DIR"
sudo touch "$LOG_DIR/access.log"
sudo touch "$LOG_DIR/error.log"

echo "🔒 Asignando permisos a nginxuser:docker"
sudo chown -R nginxuser:docker "$LOG_DIR"
sudo chmod -R 664 "$LOG_DIR"/*

echo "✅ Logs para Nginx listos en:"
ls -l "$LOG_DIR"
