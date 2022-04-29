#! /usr/bin/env bash

# Delete previous èersistent data
sudo rm -rf app data
mkdir app data
# Change the owner of the data folder to mariadb UID
podman unshare chown 999:999 data
# Copy the application project from the container folder
podman run -d --name sylius-app-copy-files docker.io/procsiab/sylius:v1.0-amd64
podman cp sylius-app-copy-files:/var/www/html/app/. app/
podman rm -f sylius-app-copy-files
# Copy the default locale and currency declaration to the project
cp ./locale_currency.yaml app/config/services.yaml
# Use ACLs to allow www-data to write var and media
podman unshare setfacl -dR -m u:82:rwX app/var
podman unshare setfacl -R -m u:82:rwX app/var
podman unshare setfacl -dR -m u:82:rwX app/public/media
podman unshare setfacl -R -m u:82:rwX app/public/media
