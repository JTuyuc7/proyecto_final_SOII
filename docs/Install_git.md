# 📦 Instalación y Configuración de Git

Este documento describe los pasos necesarios para instalar y configurar Git en el servidor, lo que permitirá un mejor control de versiones y facilitará la colaboración entre desarrolladores.

## 🛠️ Instalación de Git

Para instalar Git de forma global, de modo que todos los usuarios puedan utilizarlo, ejecuta los siguientes comandos como usuario root:

```bash
sudo apt update
sudo apt install git
```

## ⚙️ Configuración básica

Una vez instalado Git, es necesario configurarlo con la información del usuario. Esta configuración puede realizarse a nivel global (para todos los repositorios) o a nivel local (para un repositorio específico).

### Configuración global

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

### Verificar la configuración

Para verificar que la configuración se ha aplicado correctamente:

```bash
git config --list
```

## 🔑 Configuración de SSH para Git (opcional)

Para evitar tener que introducir las credenciales cada vez que se interactúa con un repositorio remoto, es recomendable configurar una clave SSH:

1. Genera una clave SSH siguiendo las instrucciones en [Configuración de SSH](./ssh_creation.md)
2. Agrega la clave pública a tu cuenta de GitHub, GitLab o el servicio que utilices

## 🌿 Flujos de trabajo recomendados

### Gitflow

Gitflow es un modelo de ramificación para Git que define un conjunto estricto de reglas para la creación y fusión de ramas:

- `main`: Contiene código de producción estable
- `develop`: Rama de desarrollo principal
- `feature/*`: Ramas para nuevas características
- `release/*`: Ramas para preparar versiones para producción
- `hotfix/*`: Ramas para correcciones urgentes en producción

### Trunk-based Development

Un enfoque más simple donde:

- La mayoría del desarrollo ocurre en la rama principal (`main` o `trunk`)
- Se utilizan ramas de corta duración para características o correcciones
- Se integran cambios frecuentemente a la rama principal

## 📝 Buenas prácticas

1. **Commits atómicos**: Cada commit debe representar un cambio lógico y completo
2. **Mensajes descriptivos**: Utiliza mensajes claros que expliquen el propósito del cambio
3. **Pull antes de push**: Siempre actualiza tu copia local antes de enviar cambios
4. **Revisión de código**: Implementa revisiones de código antes de fusionar cambios
5. **Ignorar archivos**: Utiliza `.gitignore` para excluir archivos temporales, dependencias y configuraciones locales

## 🔍 Comandos útiles

```bash
# Clonar un repositorio
git clone <url_repositorio>

# Crear una nueva rama
git checkout -b nombre_rama

# Ver el estado actual
git status

# Añadir cambios
git add .

# Crear un commit
git commit -m "Descripción del cambio"

# Enviar cambios al repositorio remoto
git push origin nombre_rama

# Actualizar repositorio local
git pull

# Ver historial de commits
git log --oneline --graph
```

## 📚 Recursos adicionales

- [Documentación oficial de Git](https://git-scm.com/doc)
- [Guía de GitHub](https://guides.github.com/)
- [Aprende Git Branching](https://learngitbranching.js.org/)
