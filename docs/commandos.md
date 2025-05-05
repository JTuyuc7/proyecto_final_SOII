# Comandos
Comandos que son utiles pra poder brindar permisos necesarios a archivos/carpetas

### Pythonweb
```bash
sudo chown -R pythonuser:pythonuser /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb -type d -exec chmod 755 {} \;
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb -type f -exec chmod 644 {} \;
```

### FTP user
```bash
sudo ufw allow 8022/tcp
sudo ufw allow 21100:21110/tcp
```
