# Use a lightweight Linux base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    cron \
    procps \
    sysstat \
    util-linux \
    && rm -rf /var/lib/apt/lists/*

# Create the monitoruser and home directory
RUN useradd -m -s /bin/bash monitoruser

# Create the log directory and set permissions
RUN mkdir -p /home/monitoruser && \
    chown monitoruser:monitoruser /home/monitoruser

# Copy the monitoring script
COPY monitor.sh /usr/local/bin/monitor.sh
RUN chmod +x /usr/local/bin/monitor.sh

# Create cron job file
RUN echo "0 */6 * * * /usr/local/bin/monitor.sh" > /etc/cron.d/monitor-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/monitor-cron

# Apply cron job
RUN crontab /etc/cron.d/monitor-cron

# Create the log file and set proper permissions
RUN touch /home/monitoruser/rendimiento_sistema.log && \
    chown monitoruser:monitoruser /home/monitoruser/rendimiento_sistema.log

# Start cron in the foreground
CMD ["cron", "-f"]
