# Aislamiento de procesos con `hidepid=2` en Linux

Este procedimiento permite restringir la visibilidad de procesos en el sistema operativo, evitando que usuarios no privilegiados puedan ver procesos de otros usuarios a través de comandos como `htop`, `ps`, o `/proc`.

## ✅ Objetivo

Evitar que usuarios sin privilegios puedan ver procesos que no les pertenecen.

---

## 🔧 PASOS

### 1. Verificar configuración actual de `/proc`

Ejecuta:

```bash
mount | grep /proc
```

### Editar el archivo de configuracion
```bash
sudo nano /etc/fstab
```
Agregar o editar esta linea
```bash
proc /proc proc defaults,hidepid=2 0 0
```
Aplicar los cambios sin reiniciar
```bash
sudo mount -o remount /proc

```
Comportamiento esperado

Usuarios no privilegiados solo verán sus propios procesos en htop, ps, etc. root sigue viendo todo normalmente.
No afecta la funcionalidad de Docker ni servicios del sistema.
