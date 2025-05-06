#!/bin/bash

FTP_PATH="/home/ftpuser/ftpdata"
FTP_USER="ftpuser"

echo "🔧 Corrigiendo permisos para servicio FTP"
echo "📂 Carpeta: $FTP_PATH"
echo "👤 Dueño esperado: $FTP_USER"

# Asegurarse de que la carpeta existe
if [ ! -d "$FTP_PATH" ]; then
  echo "📁 Carpeta no encontrada. Creando..."
  sudo mkdir -p "$FTP_PATH"
fi

# Asignar propiedad total al usuario
sudo chown -R $FTP_USER:$FTP_USER "$FTP_PATH"

# Asignar permisos:
# - Carpetas: 755 → lectura/entrada
# - Archivos: 664 → lectura/escritura para usuario y grupo
find "$FTP_PATH" -type d -exec chmod 755 {} \;
find "$FTP_PATH" -type f -exec chmod 664 {} \;

echo "✅ Permisos aplicados correctamente para $FTP_USER"
