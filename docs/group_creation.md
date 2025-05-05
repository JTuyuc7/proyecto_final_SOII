# Pasos generales para crear un nuevo grupo
Eso nos ayudara a tener un mejor control, sobre que usuarios tendran accesso a que carpetas.
Como ejemplo usaremos la crear un de un grupo dev, para que podamos centralizar ciertas carpetas y que estos tengan acceso a los recursos necesarios.

### Crear el grup
```bash 
sudo groupadd devteam
```
### Verificar que el grupo se creo correctamente
```bash
getent group devteam
```
### Agregar al usuario postgress al grupo
```bash
sudo usermod -aG devteam postgresuser # O cualquier otro usuario
```
### Verificar que el usuario este agregado al los grupos correctos
```bash
groups postgresuser
```




