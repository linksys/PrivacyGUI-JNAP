#!/bin/sh
path=$1
if [ -z "$path" ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

export NGINX_ROOT=$path
envsubst '${NGINX_ROOT}' < dist/nginx.conf.template > dist/nginx.conf
nginx -c $path/nginx.conf
