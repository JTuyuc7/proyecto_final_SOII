#!/bin/bash

SERVICE_PATH="/opt/proyecto_so2/proyecto_final_SOII/services/postgres"
OWNER="postgresuser"

echo "🔧 Corrigiendo permisos en: $SERVICE_PATH"
echo "👤 Dueño esperado: $OWNER"

sudo chown -R "$OWNER:$OWNER" "$SERVICE_PATH"
find "$SERVICE_PATH" -type d -exec chmod 755 {} \;
find "$SERVICE_PATH" -type f -exec chmod 644 {} \;

echo "✅ Permisos ajustados para $OWNER"
