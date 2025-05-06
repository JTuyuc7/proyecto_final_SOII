# 🐳 Instalación de Docker

Este documento describe los pasos necesarios para instalar Docker en el servidor, lo que permitirá un mejor control de los procesos y facilitará la ejecución de servicios.

## 🛠️ Pasos de instalación

### 1. Actualizar paquetes

```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release
```

### 2. Agregar la clave GPG de Docker

```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

### 3. Agregar el repositorio de Docker

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### 4. Instalar Docker Engine y docker-compose

```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## 👥 Configuración de usuarios

### Verificar que el grupo de Docker existe en el sistema

```bash
getent group docker || sudo groupadd docker
```

### Agregar un usuario al grupo de Docker

```bash
sudo useradd -m -s /bin/bash nombre_usuario
sudo usermod -aG docker nombre_usuario
```

Con esta configuración, cada usuario agregado al grupo `docker` podrá ejecutar contenedores sin necesidad de usar `sudo`.

## 📝 Verificación de la instalación

Para verificar que Docker se ha instalado correctamente:

```bash
docker --version
docker-compose --version
```

Para comprobar que un usuario puede ejecutar Docker sin sudo:

```bash
su - nombre_usuario
docker ps
```

## 🔍 Solución de problemas

Si un usuario no puede ejecutar Docker sin sudo después de ser agregado al grupo:

1. Asegúrate de que el usuario ha cerrado sesión y vuelto a iniciarla después de ser agregado al grupo
2. Reinicia el servicio de Docker:
   ```bash
   sudo systemctl restart docker
   ```
3. En algunos casos, puede ser necesario reiniciar el sistema:
   ```bash
   sudo reboot
   ```
