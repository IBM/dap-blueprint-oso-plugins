#!/bin/bash

# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

# entrypoint for nginx
touch /tmp/certs.pem

echo 'starting envsubst'
hostname="https://dapcs.ibm.com" component_dn="$joined" envsubst '\$port \$hostname' < /app-root/nginx/nginx.conf.template > /app-root/nginx/nginx.conf
echo 'Starting nginx'
nginx -c /app-root/nginx/nginx.conf -g 'daemon off;' &
# Wait for the Nginx process to finish
NGINX_PID=$!
wait $NGINX_PID

# Exit with the same exit code as the Nginx process
exit $?
