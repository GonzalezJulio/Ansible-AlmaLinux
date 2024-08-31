FROM almalinux:8

# Actualizar el sistema e instalar los paquetes necesarios
RUN dnf update -y && \
    dnf install -y openssh-server sudo python3 && \
    dnf clean all

# Generar las claves de host SSH
RUN ssh-keygen -A

# Agregar scripts y archivos de configuración
ADD ./start.sh /start.sh
ADD ./sudoers /etc/sudoers
RUN chmod 755 /start.sh
RUN ./start.sh
ADD ./llave-devops.pub /home/devops/.ssh/authorized_keys
RUN mkdir /var/run/sshd && \
    chmod 0700 /home/devops/.ssh && \
    chown -R devops:devops /home/devops/.ssh && \
    chown -R devops:devops /home/devops && \
    usermod -s /bin/bash devops

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
