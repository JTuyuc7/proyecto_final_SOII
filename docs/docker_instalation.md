# Instalacion de docker
Para pdoer tener un mejor control de los procesos y no tener que hacer todo de forma manual, instalaremos docker en el droplet y con esto poder agilizar mejor el como se ejecutan los servicios.

```bash
# 1. Actualiza paquetes
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

# 2. Agrega la clave GPG de Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 3. Agrega el repositorio de Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Instala Docker Engine y docker-compose
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

```
Esto instalara docker y lo dejara disponible para todos los usuarios que se creen posteriormente

#### Verifica que el grup de docker exista en el sistema
```bash
getent group docker || sudo groupadd docker
```

#### Agregar algun usuario al grupo de docker
```bash
sudo useradd -m -s /bin/bash nombre_usuario
sudo usermod -aG docker nombre_usuario
```
con esto cada usuario agregado deberia poder ejecutar algun contenedor de docker sin la necesida de tener que instalarlo en su carpeta o usar sudo.
