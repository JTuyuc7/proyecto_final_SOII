#!/bin/bash

FTP_PATH="/home/ftpuser/ftpdata"
FTP_USER="ftpuser"

echo "🔧 Corrigiendo permisos para servicio FTP"
echo "📂 Carpeta: $FTP_PATH"
echo "👤 Dueño esperado: $FTP_USER"

# Asignar propiedad
sudo chown -R $FTP_USER:$FTP_USER "$FTP_PATH"

# Permitir lectura/escritura (según configuración del contenedor)
find "$FTP_PATH" -type d -exec chmod 755 {} \;
find "$FTP_PATH" -type f -exec chmod 644 {} \;

echo "✅ Permisos aplicados correctamente para $FTP_USER"
