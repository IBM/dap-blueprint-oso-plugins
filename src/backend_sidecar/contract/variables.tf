# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

variable DEBUG {
  type        = bool
  description = "Create debug contracts, plaintext"
  default     = false
}

variable HPCR_CERT {
  type        = string
  description = "Public HPCR certificate for contract encryption"
  nullable    = true
  default     = null
}

variable SIDECAR_IMAGE {
  type        = string
  description = "signingservice_sidecar image name."
}

variable REGISTRY_URL {
  type        = string
  description = "Registry URL to pull an image."
}

variable REGISTRY_USERNAME {
  type        = string
  description = "Username to access your registry."
}

variable REGISTRY_PASSWORD {
  type        = string
  description = "Password to access your registry"
}

variable REGISTRY_INSECURE {
  type        = bool
  description = "Set registry to insecure, private registry with self-signed certificate"
  default     = false
}

variable NOTARY_URL {
  type        = string
  description = "URL of your notary server"
  default     = ""
}

variable DCT_PUBKEY {
  type        = string
  description = "Public key for docker content trust."
  default     = ""
}

variable "SSH_PUBKEY" {
  type        = string
  description = "SSH public key to access a sidecar container (should be used only for debugging)."
  default     = ""
}

variable "SSH_PORT" {
  type        = string
  description = "SSH Port (should be used only for debugging)."
}

variable "BACKEND_ENDPOINT" {
  type        = string
  description = "Backend endpoint consisting of IP address/Hostname and port (xxx.xxx.xxx.xxx:pppp)."
}

variable "PORT" {
  type        = string
  description = "Sidecar port."
  default     = "4000"
}

variable "COMPONENT_CERTS" {
  type        = string
  description = "Component certificate bundle pem file"
}

variable "BACKEND_KEY" {
  type        = string
  description = "Backend sidecar key pem file"
  sensitive   = true
}

variable "BACKEND_CERT" {
  type        = string
  description = "Backend sidecar cert pem file"
}

variable "CLIENT_CERTS_ENABLED" {
  type        = string
  description = "Enable client cert"
  default     = "true"
}

variable "MTLS_ENABLED" {
  type        = string
  description = "Enable component mtls"
  default     = "true"
}

variable "SYSLOG_HOSTNAME" {
  type        = string
  description = "Syslog server hostname"
}

variable "SYSLOG_PORT" {
  type        = number
  description = "Syslog server port number"
}

variable "SYSLOG_SERVER_CERT" {
  type        = string
  description = "Syslog server certificate"
}

variable "SYSLOG_CLIENT_CERT" {
  type        = string
  description = "Syslog server client certificate"
}

variable "SYSLOG_CLIENT_KEY" {
  type        = string
  sensitive   = true
  description = "Syslog server client key"
}
