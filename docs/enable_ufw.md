# 🔥 Habilitación y Configuración de UFW (Uncomplicated Firewall)

Este documento describe cómo habilitar y configurar el firewall UFW para controlar el acceso a los servicios del servidor, permitiendo solo los puertos necesarios y bloqueando el resto del tráfico.

## 📋 ¿Qué es UFW?

UFW (Uncomplicated Firewall) es una interfaz simplificada para iptables que facilita la configuración de un firewall. Permite controlar qué puertos están abiertos y a qué direcciones IP se les permite conectarse.

## ⚠️ Precauciones importantes

Por defecto, el droplet no expone ningún puerto, es decir, toda la comunicación es interna entre el servidor. Para poder habilitar puertos al exterior es importante definir las reglas correctamente.

> **ADVERTENCIA**: Si estás conectado por SSH, es **CRÍTICO** permitir el acceso SSH antes de habilitar UFW, o podrías quedarte sin acceso al servidor.

## 🛠️ Pasos para habilitar UFW

### 1. Permitir acceso SSH

Antes de habilitar UFW, debemos asegurarnos de que el acceso SSH esté permitido:

```bash
sudo ufw allow OpenSSH
```

Este comando permite el acceso a través del puerto 22 (SSH), lo que garantiza que podamos seguir conectándonos al servidor después de habilitar el firewall.

> **Nota**: Si estás usando un puerto diferente para SSH (ej. 2222), debes permitir ese puerto específico:
> ```bash
> sudo ufw allow 2222/tcp
> ```

### 2. Habilitar UFW

Una vez que hemos permitido el acceso SSH, podemos habilitar UFW:

```bash
sudo ufw enable
```

Se te pedirá confirmación. Escribe "y" y presiona Enter para continuar.

### 3. Verificar el estado de UFW

Para comprobar que UFW está funcionando correctamente:

```bash
sudo ufw status verbose
```

Si todo está configurado correctamente, deberías ver algo como:

```
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere
22/tcp (v6)                ALLOW IN    Anywhere (v6)
```

## 🔓 Habilitar puertos para servicios

Una vez habilitado UFW, podemos comenzar a abrir acceso a los puertos necesarios para nuestros servicios.

### Permitir acceso a PostgreSQL

```bash
sudo ufw allow 6432/tcp
```

### Permitir acceso a Nginx

```bash
sudo ufw allow 80/tcp
```

### Permitir acceso a Python Web

```bash
sudo ufw allow 8080/tcp
```

### Permitir acceso a FTP

```bash
sudo ufw allow 21/tcp
sudo ufw allow 21100:21110/tcp  # Rango de puertos para FTP pasivo
```

### Recargar las reglas después de cambios

Después de agregar nuevas reglas, es recomendable recargar UFW:

```bash
sudo ufw reload
```

## 🔍 Verificar las reglas configuradas

Para ver todas las reglas configuradas:

```bash
sudo ufw status
```

Deberías ver algo como:

```
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       Anywhere
6432/tcp                   ALLOW       Anywhere
80/tcp                     ALLOW       Anywhere
8080/tcp                   ALLOW       Anywhere
21/tcp                     ALLOW       Anywhere
21100:21110/tcp            ALLOW       Anywhere
22/tcp (v6)                ALLOW       Anywhere (v6)
6432/tcp (v6)              ALLOW       Anywhere (v6)
80/tcp (v6)                ALLOW       Anywhere (v6)
8080/tcp (v6)              ALLOW       Anywhere (v6)
21/tcp (v6)                ALLOW       Anywhere (v6)
21100:21110/tcp (v6)       ALLOW       Anywhere (v6)
```

## 🔒 Configuraciones avanzadas

### Permitir acceso desde una IP específica

Si deseas permitir el acceso a un puerto solo desde una dirección IP específica:

```bash
sudo ufw allow from 192.168.1.100 to any port 6432
```

### Denegar acceso a un puerto

Si necesitas bloquear el acceso a un puerto específico:

```bash
sudo ufw deny 3306/tcp
```

### Eliminar una regla

Si necesitas eliminar una regla existente:

```bash
# Primero, lista las reglas con números
sudo ufw status numbered

# Luego, elimina la regla por su número
sudo ufw delete 2
```

## 📝 Buenas prácticas

1. **Principio de privilegio mínimo**: Abre solo los puertos necesarios para el funcionamiento de tus servicios
2. **Revisión periódica**: Verifica regularmente las reglas del firewall para asegurar que no haya puertos innecesarios abiertos
3. **Monitoreo**: Configura alertas para intentos de conexión bloqueados
4. **Documentación**: Mantén un registro de los puertos abiertos y su propósito
5. **Actualización**: Mantén UFW actualizado para protegerte contra vulnerabilidades conocidas
