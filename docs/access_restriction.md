# Restringir accesos
Para que los usuarios definidos en el servidor tengan accesso y puedan ejecutar unicamente los archivos que les correspondend, es necesario delimitar permisos.

```bash
# Cambiar dueño de la carpeta de postgres
# sudo chown -R postgresuser:devteam /opt/proyecto_so2/proyecto_final_SOII/services/postgres
# sudo chown -R <usuario>:<grupo> /opt/proyecto_so2/proyecto_final_SOII/services/<carpeta>
sudo chown -R <usuario>:<grupo> /opt/proyecto_so2/proyecto_final_SOII/services/postgres

# Limitar acceso exclusivamente a postgresuser
sudo chmod -R 700 /opt/proyecto_so2/proyecto_final_SOII/services/postgres
```
Esto garantizar que el usuario logueado solamente tenga acceso a la carpeta que le corresponde.