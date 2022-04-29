#!/usr/bin/env bash

# Update Composer dependencies
podman-compose exec app sh -c 'composer update --no-interaction'
# Install the application AFTER connecting to the database
podman-compose exec app sh -c 'php bin/console sylius:install'
# GitHub issue sylius/sylius:
# https://github.com/Sylius/Sylius/issues/12893#issuecomment-898884792
sed -i "s/import sass from 'gulp-sass';/var sass = require('gulp-sass')(require('sass'));/g" ./app/src/Sylius/Bundle/ShopBundle/gulpfile.babel.js
sed -i "s/import sass from 'gulp-sass';/var sass = require('gulp-sass')(require('sass'));/g" ./app/src/Sylius/Bundle/AdminBundle/gulpfile.babel.js
podman-compose exec app sh -c 'apk add yarn python2 g++ && yarn add gulp-sass@5.0.0 && yarn add gulp-dart-sass@^1.0.2'
# Build the graphical assets
podman-compose exec app sh -c 'yarn install && yarn build'
