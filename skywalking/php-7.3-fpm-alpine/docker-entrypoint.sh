#!/usr/bin/env sh

set -e

grpc=$SW_OAP_ADDRESS

if [ ! $grpc ]; then
    grpc="127.0.0.1:11800"
fi

sed -i "s/127.0.0.1:11800/$grpc/g" $PHP_INI_DIR/conf.d/ext-skywalking.ini

exec "$@"