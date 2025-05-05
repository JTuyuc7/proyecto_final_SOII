#!/bin/bash

sudo chown -R pythonuser:pythonuser /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb -type d -exec chmod 755 {} \;
sudo find /opt/proyecto_so2/proyecto_final_SOII/services/pythonweb -type f -exec chmod 644 {} \;