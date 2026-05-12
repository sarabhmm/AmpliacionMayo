#!/bin/bash
# provision.sh — Aprovisionamiento automatizado WebFusion Digital S.L.
set -e  # Detener ejecución ante cualquier error

echo "============================================"
echo " Iniciando aprovisionamiento WebFusion..."
echo "============================================"

# 1. ACTUALIZACIÓN DEL SISTEMA
apt-get update -y && apt-get upgrade -y

# 2. INSTALACIÓN DE DEPENDENCIAS PREVIAS
apt-get install -y ca-certificates curl gnupg lsb-release git unzip

# 3. INSTALACIÓN DE DOCKER (repositorio oficial)
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io \
    docker-buildx-plugin docker-compose-plugin

# 4. CONFIGURACIÓN DE DOCKER
systemctl enable docker && systemctl start docker
usermod -aG docker vagrant

# 5. CLONACIÓN / ACTUALIZACIÓN DEL REPOSITORIO GITHUB
REPO_URL="https://github.com/tu-usuario/webfusion-wordpress.git"
REPO_DIR="/tmp/webfusion-repo"

if [ -d "$REPO_DIR" ]; then
    echo "Repositorio detectado. Actualizando con git pull..."
    cd "$REPO_DIR" && git pull origin main
else
    echo "Clonando repositorio desde GitHub..."
    git clone "$REPO_URL" "$REPO_DIR"
fi

# 6. COPIA DE ARCHIVOS AL DIRECTORIO DE WORDPRESS
WP_CONTENT="/vagrant/wordpress/wp-content"
mkdir -p "$WP_CONTENT/themes/webfusion-theme"
cp -r "$REPO_DIR/wordpress/wp-content/themes/webfusion-theme/"* \
    "$WP_CONTENT/themes/webfusion-theme/"
echo "Archivos PHP copiados al directorio de WordPress."

# 7. DESPLIEGUE DE CONTENEDORES DOCKER
cd /vagrant
docker compose down 2>/dev/null || true
docker compose up -d

echo "============================================"
echo " Aprovisionamiento completado exitosamente."
echo " WordPress en: http://localhost:8080"
echo "============================================"

