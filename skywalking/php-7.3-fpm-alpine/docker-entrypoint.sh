#!/usr/bin/env sh

set -e

grpc=$SW_OAP_ADDRESS
app_code=$APP_CODE;

if [ ! $grpc ]; then
    grpc="127.0.0.1:11800"
fi

if [ ! $app_code ]; then
    app_code="MyProjectName"
fi

sed -i "s/127.0.0.1:11800/$grpc/g" $PHP_INI_DIR/conf.d/docker-php-ext-skywalking.ini
sed -i "s/MyProjectName/$app_code/g" $PHP_INI_DIR/conf.d/docker-php-ext-skywalking.ini

exec "$@"