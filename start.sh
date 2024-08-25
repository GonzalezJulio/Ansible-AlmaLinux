#!/bin/bash

# Función para crear un usuario y configurar contraseñas
__create_user() {
    # Crear un usuario para SSH
    if ! id "devops" &>/dev/null; then
        useradd -m devops
        echo "Usuario 'devops' creado."
    else
        echo "El usuario 'devops' ya existe."
    fi

    # Configurar contraseñas
    echo "root:master" | chpasswd
    echo "devops:master" | chpasswd
}

# Llamar a la función para crear usuarios
__create_user
