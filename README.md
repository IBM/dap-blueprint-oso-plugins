# Digital Asset Platform Cold Storage Generic Plugins

This repo maintains the document and code to define [Digital Asset Platform Blueprint](https://github.com/IBM/dap-blueprint) generic plugins for the Offline Signing Orchestrator.

## Building
### Build environment variables
| Environment Variable  | Description                                                                 |
| --------------------- | --------------------------------------------------------------------------- |
| REGISTRY_URL          | URL of your IBM container registry (e.g., us.icr.io). |
| REGISTRY_NAMESPACE    | IBM container registry namespace which you created at Prerequisites 3 (e.g., dap-blueprint). |
| DBAAS_CA              | HPDBaaS certificate authority which you downloaded at Prerequisites 6. Please paste the content of a downloaded certificate authority file without `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----`. |
| BUILD_TIME_SECRET     | An arbitrary string used as a build-time secret. This secret is used to generate signing and encryption keys with `DEPLOY_TIME_SECRET` which is specified at deploy time. |
| OLD_BUILD_TIME_SECRET | A build-time secret used at the previous build. This is needed only for key rotation. In general, please keep empty like `OLD_BUILD_TIME_SECRET=`. |

### Frontend Sidecar
```
export REGISTRY_URL=us.icr.io
export REGISTRY_NAMESPACE=<REGISTRY_NAMESPACE>
export DBAAS_CA=<CA>
export BUILD_TIME_SECRET=<BUILD_TIME_SECERT>
OLD_BUILD_TIME_SECRET=<OLD_BUILD_TIME_SECRET>

make frontend_sidecar
```

### Backend Sidecar
```
export REGISTRY_URL=us.icr.io
export REGISTRY_NAMESPACE=<REGISTRY_NAMESPACE>

make backend_sidecar
```

### Sidecar Contracts
1. Change the working directory to `contracts`
1. For both backend_sidecar and frontend_sidecar directories, copy the `terraform.tfvars.template` file to `terraform.tfvars` and fill out the required variables
1. Generate the contracts: `./create_contracts.sh` under the `contracts` directory
1. Copy the generated contracts from `user_data` to the appropriate folders within the Offline Signing Orchestrator's conductors user_data