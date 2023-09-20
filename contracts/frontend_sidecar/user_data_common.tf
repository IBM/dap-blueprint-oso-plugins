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
      "DEPLOY_TIME_SECRET": var.DEPLOY_TIME_SECRET,
      "OLD_DEPLOY_TIME_SECRET": var.OLD_DEPLOY_TIME_SECRET,
      "ARGON2_SALT": var.ARGON2_SALT,
      "COS_API_KEY": var.COS_API_KEY,
      "COS_ID": var.COS_ID,
      "DAP_BACKUP_BUCKET": var.DAP_BACKUP_BUCKET,
      "SSH_PUBKEY": var.SSH_PUBKEY,
      "SSH_PORT": var.SSH_PORT,
      "PORT": var.PORT,
      "COMPONENT_CERTS": var.COMPONENT_CERTS,
      "FRONTEND_KEY": var.FRONTEND_KEY,
      "FRONTEND_CERT": var.FRONTEND_CERT,
      "CLIENT_CERTS_ENABLED": var.CLIENT_CERTS_ENABLED,
      "MTLS_ENABLED": var.MTLS_ENABLED,
      "SYSLOG_HOSTNAME": var.SYSLOG_HOSTNAME,
      "SYSLOG_PORT": tostring(var.SYSLOG_PORT),
      "SYSLOG_SERVER_CERT": var.SYSLOG_SERVER_CERT,
      "SYSLOG_CLIENT_CERT": var.SYSLOG_CLIENT_CERT,
      "SYSLOG_CLIENT_KEY": var.SYSLOG_CLIENT_KEY,
      "TXQUEUE_HOST": var.TXQUEUE_HOST,
      "TXQUEUE_PORT": var.TXQUEUE_PORT,
      "TXQUEUE_CERT": var.TXQUEUE_CERT,
      "TXQUEUE_CA": var.TXQUEUE_CA,
    }
  }
  workload_template = {
    "type" : "workload",
    "auths": local.auths,
    "images": "${var.DCT_PUBKEY != "" ? local.images : {}}"
  }
}
