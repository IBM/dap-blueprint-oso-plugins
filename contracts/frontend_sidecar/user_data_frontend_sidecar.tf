# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

resource "local_file" "frontend_sidecar_docker_compose" {
  content = templatefile(
    "${path.module}/frontend_sidecar.yml.tftpl",
    { tpl = {
      image = var.SIDECAR_IMAGE,
    } },
  )
  filename = "frontend_sidecar/docker-compose.yml"
  file_permission = "0664"
}

# archive of the folder containing docker-compose file. This folder could create additional resources such as files 
# to be mounted into containers, environment files etc. This is why all of these files get bundled in a tgz file (base64 encoded)
resource "hpcr_tgz" "frontend_sidecar_workload" {
  depends_on = [ local_file.frontend_sidecar_docker_compose ]
  folder = "frontend_sidecar"
}


locals {
  frontend_sidecar_compose = {
    "compose" : {
      "archive" : hpcr_tgz.frontend_sidecar_workload.rendered
    }
  }
  frontend_sidecar_workload = merge(local.workload_template, local.frontend_sidecar_compose)
}

# In this step we encrypt the fields of the contract and sign the env and workload field. The certificate to execute the 
# encryption it built into the provider and matches the latest HPCR image. If required it can be overridden. 
# We use a temporary, random keypair to execute the signature. This could also be overriden. 
resource "hpcr_text_encrypted" "frontend_sidecar_contract" {
  text      = yamlencode(local.frontend_sidecar_workload)
  cert      = var.HPCR_CERT
}

resource "local_file" "frontend_sidecar_contract" {
  count    = var.DEBUG ? 1 : 0
  content  = yamlencode(local.frontend_sidecar_workload)
  filename = "frontend_sidecar_contract.yml"
  file_permission = "0664"
}

resource "local_file" "frontend_sidecar_contract_encrypted" {
  content  = hpcr_text_encrypted.frontend_sidecar_contract.rendered
  filename = "frontend_sidecar.yml"
  file_permission = "0664"
}
