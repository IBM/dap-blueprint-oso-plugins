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

variable "TXQUEUE_HOST" {
  type        = string
  description = "Mongo TXQUEUE databasea fqdn host (note should not be the floating ip address)"
}

variable "TXQUEUE_PORT" {
  type        = string
  description = "Mongo TXQUEUE database port number"
}

variable "TXQUEUE_CERT" {
  type        = string
  sensitive   = true
  description = "Mongo TXQUEUE client certificate"
}

variable "TXQUEUE_CA" {
  type        = string
  sensitive   = true
  description = "Mongo TXQUEUE ca"
}
