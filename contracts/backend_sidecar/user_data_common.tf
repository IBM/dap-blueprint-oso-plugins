# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

locals {
  auths = {
    (var.REGISTRY_URL) : {
      "username": var.REGISTRY_USERNAME,
      "password": var.REGISTRY_PASSWORD,
      "insecure": var.REGISTRY_INSECURE
    }
  }
  images = {
    "dct" : {
      (var.SIDECAR_IMAGE) : {
        "notary": var.NOTARY_URL,
        "publicKey": var.DCT_PUBKEY
      }
    }
  }
  env = {
    "type" : "env",
    "logging" : {
      "syslog" : {
          "hostname" : var.SYSLOG_HOSTNAME,
          "port": var.SYSLOG_PORT,
          "server": var.SYSLOG_SERVER_CERT,
          "cert": var.SYSLOG_CLIENT_CERT,
          "key": var.SYSLOG_CLIENT_KEY,
      }
    },
    "env" : {
      "SIDECAR_IMAGE": var.SIDECAR_IMAGE,
      "SYSLOG_HOSTNAME": var.SYSLOG_HOSTNAME,
      "SYSLOG_PORT": tostring(var.SYSLOG_PORT),
      "SYSLOG_SERVER_CERT": var.SYSLOG_SERVER_CERT,
      "SYSLOG_CLIENT_CERT": var.SYSLOG_CLIENT_CERT,
      "SYSLOG_CLIENT_KEY": var.SYSLOG_CLIENT_KEY,
      "SSH_PUBKEY": var.SSH_PUBKEY,
      "SSH_PORT": var.SSH_PORT,
      "BACKEND_ENDPOINT": var.BACKEND_ENDPOINT,
      "PORT": var.PORT,
      "BRIDGE_FINGERPRINT": var.BRIDGE_FINGERPRINT,
      "COMPONENT_CA_CERT": var.COMPONENT_CA_CERT,
      "BACKEND_KEY": var.BACKEND_KEY,
      "BACKEND_CERT": var.BACKEND_CERT,
      "CLIENT_CERTS_ENABLED": var.CLIENT_CERTS_ENABLED,
      "MTLS_ENABLED": var.MTLS_ENABLED,
    }
  }
  workload_template = {
    "type" : "workload",
    "auths": local.auths,
    "images": "${var.DCT_PUBKEY != "" ? local.images : {}}"
  }
}
