#! /usr/bin/env bash
sudo rm -rf app data
mkdir app data
podman unshare chown 999:999 data
podman run -d --name sylius-app-copy-files sylius-app
podman cp sylius-app-copy-files:/var/www/html/app/. app/
podman rm -f sylius-app-copy-files
