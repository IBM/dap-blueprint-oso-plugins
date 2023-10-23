#!/bin/bash

# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

# entrypoint for nginx
touch /tmp/certs.pem

# Get array of Content Names
CN_ARRAY=($(openssl storeutl -noout -text /certs/component-bundle.pem | grep 'Subject:' | sed -n 's/.*CN=//p'))

# Check that each name in the array is unique 
declare -A unique_names
for name in "${CN_ARRAY[@]}"; do
    if [[ -n "${unique_names[$name]}" ]]; then
        echo "Error: Array Contains Duplicate Names"
        tail -f /dev/null
    else
        unique_names["$name"]=1
    fi
done

# Get array of Content Names
COMPONENT_CN_ARRAY=($(openssl storeutl -noout -text /certs/component-bundle.pem | grep 'Subject:' | sed -n 's/.*CN=//p'))

# Check that each name in the array is unique 
delim=""
joined=""
for item in "${COMPONENT_CN_ARRAY[@]}"; do
  joined="$joined$delim$item"
  delim="|"
done

echo 'Starting envsubst'
HOSTNAME="https://dapcs.ibm.com" COMPONENT_DN="$joined" envsubst '\$PORT \$HOSTNAME \$COMPONENT_DN' < /app-root/nginx/nginx.conf.template > /app-root/nginx/nginx.conf
echo 'Starting nginx'
nginx -c /app-root/nginx/nginx.conf -g 'daemon off;' &
# Wait for the Nginx process to finish
NGINX_PID=$!
wait $NGINX_PID

# Exit with the same exit code as the Nginx process
exit $?