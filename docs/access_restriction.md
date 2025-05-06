## 🔐 Restringir acceso por usuario

Para garantizar que cada usuario del servidor pueda acceder **únicamente** a los archivos que le corresponden, se deben establecer permisos correctos sobre su carpeta de servicio.

```bash
# Cambiar dueño de la carpeta
sudo chown -R <usuario>:<grupo> /opt/proyecto_so2/proyecto_final_SOII/services/<carpeta>
# sudo chown -R ftpuser:docker /opt/proyecto_so2/proyecto_final_SOII/services/ftp

# Limitar acceso exclusivamente al usuario (lectura, escritura, ejecución)
# sudo chmod -R 700 /opt/proyecto_so2/proyecto_final_SOII/services/<carpeta>
sudo chmod -R 700 /opt/proyecto_so2/proyecto_final_SOII/services/ftp
