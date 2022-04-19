# Sylius OCI container

This repository has the necessary files to bootstrap a production environment for the Sylius e-commerce platform.

ℹ️  **DISCLAIMER**: I am not a contributor of the Sylius project, therefore there is no guarantee that the code provided with this repo will stay up to date and/or secure, with respect to the original project.

⚠️  **WARNING**: Before deploying to production, be sure to have changed the secrets inside the configuration file `env.local.php`, as well as the database password, for which have also a look at the `compose/container-compose.yaml` file.

## Build the container image

Run the following command (you may replace `podman` with `docker`, if using the latter:

```bash
podman build -f Containerfile.amd64 -t mycompany/sylius:latest .
```

Ypu may choose the file `Containerfile.aarch64` to target the ARM64 architecture; in that case, the package `qemu-user-static` must be installed, and the following command ran before building the image:

```bash
cp $(which qemu-aarch64-static) .
```

## Run the environment

You should have installed the `podman-compose` script, and root permissions through `sudo`.

Note that all the three following steps are mandatory to run a complete installation process.

### 1. init-env.sh

Inside the `compose` subfolder there is a script called `init-env.sh`: it **must** be run before starting the environment with podman-compose; it will create the necessary folders, set their permissions and copy the application's source inside the shared app folder.

This script can also be run to delete all data and initialize the environment (even the database's persistent data will be removed!).

### 2. podman-compose

Open the subfolder `compose` in a terminal, then run (also as non-root, with podman-compose):

```bash
./init-env.sh
podman-compose up -d
```

This will start 2 containers: a MariaDB instance and the Sylius app.

### 3. run-install.sh

Inside the `compose` subfolder there is a script called `run-install.sh`: it **must** be run after starting the environment with podman-compose; it will perform the initialization of the database, the creation of the assets and the admin account setup.

**NOTE**: The final environment will be a production Sylius installation served through Symfony.

## Issues

For issues with the application itself, please report them to the original project issue tracker [here](https://github.com/Sylius/Sylius/issues).
