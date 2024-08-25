# Usar AlmaLinux como imagen base
FROM almalinux:8

# Instalar paquetes necesarios
RUN dnf update -y && dnf install -y \
    openssh-server sudo python3 python3-apt \
    && dnf clean all

# Agregar scripts y archivos de configuración
ADD ./start.sh /start.sh
ADD ./sudoers /etc/sudoers
RUN chmod 755 /start.sh

# Ejecutar el script de inicio
RUN ./start.sh

# Configurar claves SSH
ADD ./llave-devops.pub /home/devops/.ssh/authorized_keys

# Crear directorio para el servicio SSH y configurar permisos
RUN mkdir /var/run/sshd \
    && chmod 0700 /home/devops/.ssh \
    && chown -R devops:devops /home/devops/.ssh \
    && chown -R devops:devops /home/devops \
    && usermod -s /bin/bash devops

# Exponer el puerto 22 para SSH
EXPOSE 22

# Comando para iniciar el servidor SSH
CMD ["/usr/sbin/sshd", "-D"]
