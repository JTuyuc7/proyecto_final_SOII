
# Documentación de Configuración: Proxy Inverso y Servicios Docker

Este documento describe los pasos realizados para exponer dos servicios (NGINX estático y Python HTTP) bajo un dominio público y permitir acceso por IP, usando Docker, `jwilder/nginx-proxy`, y `nginxproxy/acme-companion`.

---

## 1. DNS - Registro de Dominio Estático

1. Crear un registro A en DuckDNS o DigitalOcean:
   - Dominio principal: `proyectofinalso2.duckdns.org`
   - Subdominio estático: `web.proyectofinalso2.duckdns.org` → apunta a la IP fija del servidor.
   - Subdominio Python: `app.proyectofinalso2.duckdns.org` → apunta a la misma IP.

> **Nota**: Como la IP es fija, no necesitamos cliente de DNS dinámico.

---

## 2. Crear red Docker externa

```bash
docker network create web
```

Esta red permitirá que el proxy vea y enruté ambos contenedores.

---

## 3. Desplegar Proxy Inverso con HTTPS Automático

En `services/proxy/docker-compose.yml`:
```yml

version: '3.8'
services:
  nginx-proxy:
    image: jwilder/nginx-proxy
    container_name: nginx-proxy
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    environment:
      - DEFAULT_HOST=web.proyectofinalso2.duckdns.org
    env_file:
      - .env
    volumes:
      - /var/run/docker.sock:/tmp/docker.sock:ro
      - ./certs:/etc/nginx/certs:rw
      - ./vhost.d:/etc/nginx/vhost.d:rw
      - ./html:/usr/share/nginx/html:rw
    networks:
      - web

  acme-companion:
    image: nginxproxy/acme-companion
    container_name: acme-companion
    restart: unless-stopped
    env_file:
      - .env
    environment:
      - NGINX_PROXY_CONTAINER=nginx-proxy
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./certs:/etc/nginx/certs:rw
      - ./vhost.d:/etc/nginx/vhost.d:rw
      - ./html:/usr/share/nginx/html:rw
    depends_on:
      - nginx-proxy
    networks:
      - web
networks:
  web:
    external: true
```


En `services/proxy/.env`:

```dotenv
DEFAULT_EMAIL=tu-email@ejemplo.com
NGINX_PROXY_CONTAINER=nginx-proxy
```

Lanzar el proxy:

```bash
cd services/proxy
docker-compose up -d
```

---

## 4. Configurar Servicio NGINX Estático

En `services/nginx/docker-compose.yml`:

```yaml
version: '3.8'
services:
  web:
    image: nginx:latest
    container_name: nginx_web
    restart: unless-stopped
    volumes:
      - ./html:/usr/share/nginx/html:ro
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - /var/log/proyecto_so2/nginx/:/var/log/nginx/
    expose:
      - "80"
    env_file:
      - .env
    networks:
      - web

networks:
  web:
    external: true
```

En `services/nginx/.env` (o el `.env` compartido):

```dotenv
VIRTUAL_HOST=web.proyectofinalso2.duckdns.org
LETSENCRYPT_HOST=web.proyectofinalso2.duckdns.org
LETSENCRYPT_EMAIL=tu-email@ejemplo.com
```

Lanzar el servicio:

```bash
cd services/nginx
docker-compose up -d
```

---

## 5. Configurar Servicio Python HTTP

En `services/pythonweb/docker-compose.yml`:

```yaml
version: '3.8'
services:
  pythonweb:
    image: python:3.11-slim
    container_name: python_web
    working_dir: /usr/src/app
    volumes:
      - /home/pythonuser/public_html:/usr/src/app/public
      - ./index.html:/usr/src/app/public/index.html
      - /var/log/proyecto_so2/pythonweb:/usr/src/app/logs
    command: sh -c "cd /usr/src/app/public && python -m http.server 8080 > /usr/src/app/logs/server.log 2>&1"
    expose:
      - "8080"
    restart: unless-stopped
    env_file:
      - .env
    networks:
      - web

networks:
  web:
    external: true
```

En `services/pythonweb/.env`:

```dotenv
VIRTUAL_HOST=app.proyectofinalso2.duckdns.org
LETSENCRYPT_HOST=app.proyectofinalso2.duckdns.org
LETSENCRYPT_EMAIL=tu-email@ejemplo.com
```

Lanzar el servicio:

```bash
cd services/pythonweb
docker-compose up -d
```

---

## 6. Agregar Acceso Directo por IP

### Método A: `DEFAULT_HOST` (fallback)

Con `DEFAULT_HOST=web.proyectofinalso2.duckdns.org` en el proxy, las peticiones a `http://<TU_IP>` sin `Host` coincidente caerán en el sitio estático.

**Recargar proxy**:

```bash
cd services/proxy
docker-compose up -d --force-recreate --no-deps nginx-proxy
```

### Método B: Exponer puerto directo

En `services/nginx/docker-compose.yml`, descomentar:

```yaml
ports:
  - "8080:80"
```

Luego:

```bash
cd services/nginx
docker-compose up -d --force-recreate web
```

Y acceder a:

```
http://<TU_IP>:8080
```

---

## 7. Verificación

* **Logs proxy**:

```bash
docker-compose logs -f nginx-proxy acme-companion
```

- **Acceso navegador**:
  - https://web.proyectofinalso2.duckdns.org
  - https://app.proyectofinalso2.duckdns.org
  - http://<TU_IP>:8080 (opción puerto directo)

