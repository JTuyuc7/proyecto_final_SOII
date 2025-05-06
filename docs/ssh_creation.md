# 🔑 Configuración de SSH para Conexión Segura

Este documento describe los pasos necesarios para crear y configurar claves SSH para conectarse de forma segura a un servidor (droplet) de DigitalOcean desde diferentes sistemas operativos.

## 📋 Índice
- [Configuración en macOS](#configuración-en-macos)
- [Configuración en Windows](#configuración-en-windows)
- [Configuración en Android (Termux)](#configuración-en-android-termux)
- [Agregar nuevas claves SSH al servidor](#agregar-nuevas-claves-ssh-al-servidor)

## 🍎 Configuración en macOS

### Generar la clave SSH

1. Abre Terminal y ejecuta:

```bash
ssh-keygen -t ed25519 -C "tu-correo@example.com"
```

2. Cuando se te pregunte por la ubicación, puedes aceptar la ruta predeterminada o especificar una personalizada:

```
/Users/<tu_usuario>/.ssh/id_ed25519_digitalocean
```

> **Nota**: Es recomendable usar un nombre descriptivo para distinguir esta clave de otras que puedas tener.

3. Se te pedirá una frase de contraseña (passphrase). Es recomendable establecer una para mayor seguridad.

4. El proceso generará dos archivos:
   - `id_ed25519_digitalocean` (clave privada)
   - `id_ed25519_digitalocean.pub` (clave pública)

### Configurar el cliente SSH

Para simplificar la conexión, puedes configurar el archivo `config` de SSH:

1. Edita o crea el archivo de configuración:

```bash
nano ~/.ssh/config
```

2. Agrega la siguiente configuración:

```
Host digitalocean-server
     HostName <IP_DEL_SERVIDOR>
     User root
     IdentityFile ~/.ssh/id_ed25519_digitalocean
```

3. Guarda el archivo (Ctrl+O, Enter, Ctrl+X en nano).

### Conectarse al servidor

Ahora puedes conectarte simplemente con:

```bash
ssh digitalocean-server
```

La primera vez que te conectes, se te pedirá que confirmes la autenticidad del host. Escribe "yes" para continuar.

## 🪟 Configuración en Windows

### Generar la clave SSH

1. Abre PowerShell o Git Bash y ejecuta:

```bash
ssh-keygen -t ed25519 -C "tu-correo-windows@example.com"
```

2. Cuando se te pregunte por la ubicación, puedes especificar:

```
C:\Users\<tu_usuario>\.ssh\id_ed25519_digitalocean_windows
```

3. Se te pedirá una frase de contraseña (passphrase). Es recomendable establecer una para mayor seguridad.

### Configurar el cliente SSH

1. Crea o edita el archivo de configuración SSH:

```bash
notepad C:\Users\<tu_usuario>\.ssh\config
```

2. Agrega la siguiente configuración:

```
Host digitalocean-windows
     HostName <IP_DEL_SERVIDOR>
     User root
     IdentityFile C:\Users\<tu_usuario>\.ssh\id_ed25519_digitalocean_windows
```

3. Guarda el archivo.

### Conectarse al servidor

Ahora puedes conectarte con:

```bash
ssh digitalocean-windows
```

## 📱 Configuración en Android (Termux)

### Instalar Termux

1. Instala [Termux desde F-Droid](https://f-droid.org/packages/com.termux/) (recomendado) o Google Play Store.
2. Abre Termux y actualiza los paquetes:

```bash
pkg update && pkg upgrade
```

3. Instala OpenSSH:

```bash
pkg install openssh
```

### Generar la clave SSH

1. Ejecuta:

```bash
ssh-keygen -t ed25519 -C "android-user"
```

2. Acepta la ruta predeterminada:

```
/data/data/com.termux/files/home/.ssh/id_ed25519
```

3. Opcionalmente, establece una frase de contraseña.

### Configurar el cliente SSH

1. Crea el directorio y archivo de configuración:

```bash
mkdir -p ~/.ssh && nano ~/.ssh/config
```

2. Agrega la siguiente configuración:

```
Host do
     HostName <IP_DEL_SERVIDOR>
     User root
     IdentityFile ~/.ssh/id_ed25519
```

3. Guarda el archivo (Ctrl+O, Enter, Ctrl+X en nano).

### Conectarse al servidor

Ahora puedes conectarte con:

```bash
ssh do
```

## 🔄 Agregar nuevas claves SSH al servidor

Hay dos formas de agregar nuevas claves SSH a un servidor existente:

### Método 1: Desde la interfaz de DigitalOcean

1. Accede a los [ajustes de seguridad de tu cuenta](https://cloud.digitalocean.com/account/security)
2. Haz clic en "Add SSH Key"
3. Pega el contenido de tu clave pública (el archivo `.pub`)
4. Asigna un nombre descriptivo a la clave
5. Haz clic en "Add SSH Key"

### Método 2: Manualmente desde el servidor

1. Conéctate al servidor con una clave SSH ya configurada o mediante la consola web
2. Edita el archivo de claves autorizadas:

```bash
nano ~/.ssh/authorized_keys
```

3. Agrega el contenido de tu clave pública (el archivo `.pub`) en una nueva línea
4. Guarda el archivo (Ctrl+O, Enter, Ctrl+X en nano)

## 🔒 Buenas prácticas de seguridad

1. **Protege tus claves privadas**: Nunca compartas tus archivos de clave privada
2. **Usa frases de contraseña**: Siempre protege tus claves con una frase de contraseña fuerte
3. **Usa nombres descriptivos**: Nombra tus claves de manera que puedas identificar fácilmente su propósito
4. **Revisa periódicamente**: Verifica regularmente las claves autorizadas en tu servidor
5. **Usa ed25519**: Este tipo de clave ofrece un buen equilibrio entre seguridad y rendimiento
6. **Rota tus claves**: Considera generar nuevas claves periódicamente, especialmente para servidores críticos

## 📝 Solución de problemas comunes

### Permisos incorrectos

Si recibes errores sobre permisos demasiado abiertos:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519*
chmod 600 ~/.ssh/config
```

### Clave no reconocida

Si el servidor no reconoce tu clave:

1. Verifica que la clave pública esté correctamente agregada al archivo `authorized_keys`
2. Asegúrate de estar usando la clave privada correcta
3. Comprueba que los permisos de los archivos sean adecuados

### Problemas de conexión

Si no puedes conectarte:

1. Verifica que el servidor esté en línea
2. Comprueba que el puerto SSH (generalmente 22) esté abierto en el firewall
3. Intenta usar el modo verbose para obtener más información:

```bash
ssh -v digitalocean-server
```
