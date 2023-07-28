#!/bin/bash

# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

mkdir -p /root/.ssh/
echo ${SSH_PUBKEY} > /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

mkdir -p /certs

# Write certs to file
echo "${COMPONENT_CERTS}" | base64 --decode | gzip --decompress > /certs/component-bundle.pem
echo "${BACKEND_CERT}" | base64 --decode | gzip --decompress > /certs/backend-certificate.pem
echo "${BACKEND_KEY}" | base64 --decode | gzip --decompress > /certs/backend-key.pem

LOGDNA_TAG=backend_sidecar
CONF_FILE=supervisord-backend_sidecar.conf

mkdir -p /data/logs
mkdir -p /logging
echo "${SYSLOG_SERVER_CERT}" > /logging/ca.crt
echo "${SYSLOG_CLIENT_CERT}" > /logging/client.crt
echo "${SYSLOG_CLIENT_KEY}" > /logging/client-key.pem

cd /app-root/entrypoints

SUPERVISORD_CONF=/usr/local/etc/supervisord.conf
cp ${CONF_FILE} ${SUPERVISORD_CONF}
supervisord -c ${SUPERVISORD_CONF}
