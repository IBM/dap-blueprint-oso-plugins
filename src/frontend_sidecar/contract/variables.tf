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
  description = "sidecar image name."
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
  description = "SSH public key to access a confirmation container (should be used only for debugging)."
  default     = ""
}

variable "SSH_PORT" {
  type        = string
  description = "SSH port (should be used only for debugging)."
}

### DAP dependent ###
variable "COS_API_KEY" {
  type        = string
  description = "API key to access a cloud-object storage (COS) instance."
  default     = ""
}

variable "COS_ID" {
  type        = string
  description = "Cloud-object storage (COS) id."
  default     = ""
}

variable "DAP_BACKUP_BUCKET" {
  type        = string
  description = "Bucket name to backup the DAP information in a cloud-object storage instance."
  default     = ""
}

variable "DEPLOY_TIME_SECRET" {
  type        = string
  description = "Deploy-time secret."
  default     = ""
} 

variable "OLD_DEPLOY_TIME_SECRET" {
  type        = string
  description = "Old deploy-time secret (used only for rotating a key)."
  default     = ""
}

variable "ARGON2_SALT" {
  type        = string
  description = "A salt value to calculate a ARGON2 hash value."
  default     = ""
}

variable "PORT" {
  type        = string
  description = "Sidecar port."
  default     = "4000"
}

variable "COMPONENT_CERTS" {
  type        = string
  description = "Base64 encoded gzip of the component certificate bundle pem file"
}

variable "FRONTEND_KEY" {
  type        = string
  description = "Base64 encoded gzip of the frontend sidecar key pem file"
  sensitive   = true
}

variable "FRONTEND_CERT" {
  type        = string
  description = "Base64 encoded gzip of the frontend sidecar cert pem file"
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
