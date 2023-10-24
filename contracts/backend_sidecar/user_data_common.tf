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
      "SYSLOG_HOSTNAME": var.SYSLOG_HOSTNAME,
      "SYSLOG_PORT": tostring(var.SYSLOG_PORT),
      "SYSLOG_SERVER_CERT": var.SYSLOG_SERVER_CERT,
      "SYSLOG_CLIENT_CERT": var.SYSLOG_CLIENT_CERT,
      "SYSLOG_CLIENT_KEY": var.SYSLOG_CLIENT_KEY,
      "SSH_PUBKEY": var.SSH_PUBKEY,
      "SSH_PORT": var.SSH_PORT,
      "PORT": var.PORT,
      "COMPONENT_CA_CERT": var.COMPONENT_CA_CERT,
      "BACKEND_PLUGIN_KEY": var.BACKEND_PLUGIN_KEY,
      "BACKEND_PLUGIN_CERT": var.BACKEND_PLUGIN_CERT,
    }
  }
  workload_template = {
    "type" : "workload",
    "auths": local.auths,
    "images": {}
  }
}
