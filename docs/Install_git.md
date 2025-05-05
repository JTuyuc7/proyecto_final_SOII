# Instalacion de GIT
Para poder tener todo mas organizado y que sea mas facil para cualquier desarrollador el poder ejecutar procesos, realizar cambios y aplicarlos, se manejara un control de versionamiento y asi poder tener un mejor control.

### instalacion de git
para esto instalaremos git de forma global, para que todos los usuarios si llegase a necesitarlo puedan hacer uso del mismo, esta instalacion se debe realizar desde el usuario root.
```bash
sudo apt update
sudo apt install git
```
Una vez configurado necesitamos configurar git globalmente para poder saber si alguna persona ha realizado algun cambio.
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```


