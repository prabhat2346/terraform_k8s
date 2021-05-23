<img src="https://raw.githubusercontent.com/dentsuadmin/assets/master/terraform-logo-small.png" width="80" height="80" align="right" />
<img src="https://helm.sh/assets/images/helm-logo.svg" width="80" height="80" align="right" />

# HDFS Terraform 12 module

## Overview

This module installs aN HDFS service into a Kubernetes cluster. This forms part of the hadoop stack build.

## Pre-Requisites

* A Kubernetes cluster

## Usage

The full range of options are as follows. Check vault for default values.

```json
"helm-hadoop-hdfs-tf12": {
   "enabled": "1",
   "version": "0.0.27",
   "LogLevel": "INFO",
   "antiAffinity": "soft",
   "nameNode_limit_cpu": "2000m",
   "nameNode_limit_mem": "4096Mi",
   "nameNode_requests_cpu": "1000m",
   "nameNode_requests_mem": "2048Mi",
   "nameNode_heap_size": "12288",
   "pvc_nameNode_enabled": "1",
   "pvc_nameNode_size": "10Gi",
   "pvc_nameNode_storageclass": "default",
   "dataNode_replicas": "3",
   "dataNode_pdbMinAvailable": "2",
   "dataNode_requests_cpu": "1000m",
   "dataNode_requests_mem": "2048Mi",
   "dataNode_limit_cpu": "2000m",
   "dataNode_limit_mem": "4096Mi",
   "pvc_dataNode_enabled": "1",
   "pvc_dataNode_size": "10Gi",
   "pvc_dataNode_storageclass": "default",
   "httpFs_replicas": "2",
   "httpFs_limit_cpu": "2000m",
   "httpFs_limit_mem": "4096Mi",
   "httpFs_requests_cpu": "1000m",
   "httpFs_requests_mem": "2048Mi",
   "journalNode_limit_cpu": "1000m",
   "journalNode_limit_mem": "4096Mi",
   "journalNode_requests_cpu": "1000m",
   "journalNode_requests_mem": "2048Mi",
   "pvc_journalNode_enabled": "1",
   "pvc_journalNode_size": "10Gi",
   "pvc_journalNode_storageclass": "default",
   "ranger_audit_solr": "1",
   "ranger_audit_summary": "1",
   "ranger_enabled": "1",
   "ranger_repo": "HDFS",
   "enableDfsPermissions": "1",
   "enableHadoopAcls": "0",
   "webhdfs_enabled": "true",
   "jmx_enabled": "1",
   "jmx_image_tag":  "0.0.26",
   "dataNode_jmx_disable": "false",
   "dataNode_jmx_start_delay_seconds": "0",
   "dataNode_jmx_ssl": "false",
   "nameNode_jmx_disable": "false",
   "nameNode_jmx_start_delay_seconds": "0",
   "nameNode_jmx_ssl": "false",
   "journalNode_jmx_disable": "false",
   "journalNode_jmx_start_delay_seconds": "0",
   "journalNode_jmx_ssl": "false",
   "recovering_pvc": "0"
   }
```

\*\*/

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| external | n/a |
| helm | n/a |
| local | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_subscription\_alias | The azure subscription alias that you would like to deploy to | `string` | `""` | no |
| base\_target | n/a | `string` | `""` | no |
| deployment\_type | The deployment type | `string` | `"team"` | no |
| module\_depends\_on | Default module dependency declaration | `string` | `""` | no |
| module\_name | The Module name | `string` | `""` | no |
| namespace | Namespace to install the service to | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| complete | Indicates if modules has been run to completion |

