# Automatización de Despliegue Web con Contenedores

<p align="left">
  <img src="https://img.shields.io/badge/Vagrant-1868F2?style=for-the-badge&logo=vagrant&logoColor=white" alt="Vagrant">
  <img src="https://img.shields.io/badge/VirtualBox-214294?style=for-the-badge&logo=virtualbox&logoColor=white" alt="VirtualBox">
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker">
  <img src="https://img.shields.io/badge/WordPress-21759B?style=for-the-badge&logo=wordpress&logoColor=white" alt="WordPress">
</p>

---

## Descripcion del Proyecto

Este repositorio contiene la solucion automatizada de **Infraestructura como Codigo (IaC)** desarrollada para **WebFusion Digital S.L.**. Su objetivo principal es resolver las problematicas de sincronizacion de entornos locales y despliegues manuales propensos a fallos mediante una arquitectura reproducible y contenerizada.

El sistema levanta automaticamente un entorno completo de desarrollo basado en **WordPress 6.4** y **MySQL 8.0**, orquestado dentro de una maquina virtual **Ubuntu 22.04 LTS** aprovisionada de forma 100% declarativa.

---

## Caracteristicas Clave

*   **Aislamiento Total:** Uso de capas anidadas (Maquina Fisica, Vagrant/VirtualBox, Ubuntu Server y Docker Compose).
*   **Aprovisionamiento Identico (IaC):** Entorno identico en cualquier maquina eliminando el clasico problema de "funciona en mi ordenador".
*   **Actualizacion Inteligente:** Logica integrada para detectar cambios remotos mediante Git y sincronizarlos en vivo sin necesidad de reiniciar contenedores.
*   **Persistencia Segura:** Volumenes de datos independientes para MySQL y el directorio compartido wp-content.

---

## Ecosistema Tecnologico

*   **Virtualizacion:** Vagrant y VirtualBox
*   **Sistema Operativo Base:** Ubuntu 22.04 LTS (Jammy Jellyfish)
*   **Contenerizacion:** Docker y Docker Compose
*   **CMS y Base de Datos:** WordPress 6.4 + Apache y MySQL 8.0

---

## Estructura del Repositorio

La arquitectura de archivos del proyecto se organiza de la siguiente manera:

```text
AmpliacionMayo/
├── Vagrantfile            # Declaracion e infraestructura de la Maquina Virtual VM
├── provision.sh          # Script bash centralizado de automatización y despliegue
├── docker-compose.yml    # Orquestación de servicios e infraestructura Docker
└── wordpress/            # Volumen local mapeado hacia el contenedor de la aplicación
    └── wp-content/
        └── themes/
            └── webfusion-themes/
                └── index.php  # Plantilla principal del tema corporativo personalizado
```

---

## Guia de Instalacion y Despliegue Inicial

### Requisitos Previos
Asegurate de contar con el siguiente software instalado en tu maquina local:
*   [VirtualBox](https://virtualbox.org) (Version 7.0 o superior)
*   [Vagrant](https://hashicorp.com) (Version 2.3 o superior)
*   [Git](https://git-scm.com) (Version 2.30 o superior)
*   Conexion activa a Internet

> [!NOTE]
> **Informacion de Red:** La IP estatica `192.168.56.10` pertenece al rango host-only de VirtualBox. El reenvio de puertos mapea el puerto interno 80 al puerto local 8080.

### Pasos para Desplegar

1. **Clonar el repositorio de forma local:**
   ```bash
   git clone github.com
   cd AmpliacionMayo
   ```

2. **Iniciar la infraestructura automatizada:**
   Desde la raiz del directorio, ejecuta el comando principal:
   ```bash
   vagrant up
   ```

3. **Verificar el estado de los servicios:**
   Si deseas comprobar que los contenedores estan operativos de forma interna:
   ```bash
   vagrant ssh
   sudo docker ps
   ```

4. **Acceder a la Plataforma:**
   Abre tu navegador web e ingresa a cualquiera de las siguientes direcciones disponibles:
   *   **Host local (Puerto redirigido):** [http://localhost:8080](http://localhost:8080)
   *   **Red Privada Local:** [http://192.168.56.10](http://192.168.56.10)
   *   **Panel de Administracion:** [http://localhost:8080/wp-admin](http://localhost:8080/wp-admin)

---

## Flujo de Actualizacion Automatica

El sistema implementa una logica de aprovisionamiento inteligente. Cuando edites tus archivos PHP locales del tema y realices tus operaciones de git push, puedes sincronizar el entorno ejecutando un unico comando en tu consola local:

```bash
vagrant provision
```

### Logica Operacional del Script (provision.sh)
El aprovisionamiento ejecuta de forma segura la siguiente condicional automatizada sin necesidad de intervencion manual:

```bash
if [ -d "$REPO_DIR" ]; then
    # El repositorio ya existe en la VM -> descarga diferencias
    cd "$REPO_DIR" && git pull origin main
else
    # Primera inicialización -> clonación completa del repositorio
    git clone "$REPO_URL" "$REPO_DIR"
fi
```

> [!IMPORTANT]
> Los archivos modificados se inyectan en el volumen compartido (`/vagrant/wordpress/wp-content`) reflejando los cambios de forma inmediata en el CMS sin reiniciar ningun contenedor.

---

## Colaboradores


*   **Sara BHMM** - [@sarabhmm](https://github.com/sarabhmm) 
*   **Angela DAM** - [@angela-dam](https://github.com/angela-dam) 

