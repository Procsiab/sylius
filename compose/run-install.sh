#!/usr/bin/env bash

# Install the application AFTER starting the database container
podman-compose exec app sh -c 'php bin/console sylius:install'
# GitHub issue on sylius/sylius:
# https://github.com/Sylius/Sylius/issues/12893#issuecomment-898884792
sed -i "s/import sass from 'gulp-sass';/var sass = require('gulp-sass')(require('sass'));/g" ./app/src/Sylius/Bundle/ShopBundle/gulpfile.babel.js
sed -i "s/import sass from 'gulp-sass';/var sass = require('gulp-sass')(require('sass'));/g" ./app/src/Sylius/Bundle/AdminBundle/gulpfile.babel.js
# Download yarn build dependencies
podman-compose exec app sh -c 'apk add yarn python2 g++ && yarn add gulp-sass@5.0.0 && yarn add gulp-dart-sass@^1.0.2'
# Build the graphical assets
podman-compose exec app sh -c 'yarn install && yarn build'
