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
      "SSH_PUBKEY": var.SSH_PUBKEY,
      "SSH_PORT": var.SSH_PORT,
      "PORT": var.PORT,
      "COMPONENT_CA_CERT": var.COMPONENT_CA_CERT,
      "FRONTEND_KEY": var.FRONTEND_KEY,
      "FRONTEND_CERT": var.FRONTEND_CERT,
      "SYSLOG_HOSTNAME": var.SYSLOG_HOSTNAME,
      "SYSLOG_PORT": tostring(var.SYSLOG_PORT),
      "SYSLOG_SERVER_CERT": var.SYSLOG_SERVER_CERT,
      "SYSLOG_CLIENT_CERT": var.SYSLOG_CLIENT_CERT,
      "SYSLOG_CLIENT_KEY": var.SYSLOG_CLIENT_KEY,
    }
  }
  workload_template = {
    "type" : "workload",
    "auths": local.auths,
    "images": {}
  }
}
