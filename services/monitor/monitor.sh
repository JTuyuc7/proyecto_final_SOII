#!/bin/bash

#* Will be saving the script to save the information and create the cron job to run it every 6 hours to save the information about the system resources

# Get the current date and time
current_date=$(date +"%Y-%m-%d %H:%M:%S")

# Get the CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Virtual Memory in use
virtual_memory=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Phisical Memory in use
physical_memory=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Disk usage
disk_usage=$(df -h | grep '^/dev/' | awk '{ sum += $3 } END { print sum }')

# Save the inforamtion in a variable
info="CPU Usage: $cpu_usage%\nVirtual Memory Usage: $virtual_memory%\nPhysical Memory Usage: $physical_memory%\nDisk Usage: $disk_usage"

# Save the information to the home directory
echo -e "$info" >> /home/monitoruser/rendimiento_sistema.log

