<img src="https://raw.githubusercontent.com/dentsuadmin/assets/master/terraform-logo-small.png" width="80" height="80" align="right" />
<img src="https://raw.githubusercontent.com/dentsuadmin/assets/master/Azurelogo.png" width="80" height="80" align="right" />

### This is the azure AKS module for deploying kubernetes clusters

This module will setup a kubernetes cluster with all the relavant configurations.

Basic 3 node cluster with only default nodepool:
```
"azurerm-aks-tf12": {
    "agent_count": "3",  // The number of nodes to start with. Must be below min_count and max-count
    "min_count": "3",    // The minimum number of pods in scale set
    "max_count": "3",    // The maximum number of pods in scale set
    "node_pools": [],
    "azure_location": "westeurope",
    "enableGateway": "0",
    "enableMonitoring": "0",
    "enableRegistry": "0",
    "enableStorageAcc": "1",
    "enabled": "1",
    "k8sversion": "1.15.12",
    "linuxAdminUsername": "linuxadmin",
    "version": "0.0.11",
    "vm_disk": "250",
    "vm_os": "Linux",
    "vm_size": "Standard_DS3_v2"
  },
```

A cluster with a second node pool
```
"azurerm-aks-tf12": {
    "agent_count": "3",
    "min_count": "3",
    "max_count": "3",
    "node_pools": [
      {
         "name": "hadoop",
         "vm_size": "Standard_E8s_v3",
         "min_nodes": "3",
         "max_nodes": "3",
         "max_pods": "250"  	// Max pods per AKS cluster node. 250 is the maximum value allowed.
     }
     ],
     "azure_location": "westeurope",
     "enableGateway": "0",
     "enableMonitoring": "0",
     "enableRegistry": "0",
     "enableStorageAcc": "1",
     "enableCluster": "1",
     "enabled": "1",
     "k8sversion": "1.15.12",
     "linuxAdminUsername": "linuxadmin",
     "version": "nocluster",
     "vm_disk": "250",
     "vm_os": "Linux",
     "vm_size": "Standard_E4s_v3",
     "azure_lock_enabled": "false"
   },
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| azurerm | = 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| azuread | n/a |
| azurerm | = 2.1.0 |
| external | n/a |
| local | n/a |
| null | n/a |
| random | n/a |
| restapi | n/a |
| vault | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| anchore\_password | The anchore password to use | `string` | `"admin"` | no |
| anchore\_sslverify | Whether to verify the anchore ssl cert | `string` | `"false"` | no |
| anchore\_url | The Anchore Url to use | `string` | `"https://anchore.saas.gcp.gdp-devops.gdpdentsu.net/v1"` | no |
| anchore\_user | The anchore use to use | `string` | `"admin"` | no |
| azure\_client\_id | The Azure client id for azurerm provider | `string` | `""` | no |
| azure\_client\_secret | The Azure client secret for azurerm provider | `string` | `""` | no |
| azure\_env | Azure cloud environment, e.g. China | `string` | `"public"` | no |
| azure\_subscription\_alias | The azure subscription alias that you would like to deploy to | `string` | `""` | no |
| azure\_subscription\_id | The azure subscription id | `string` | `""` | no |
| azure\_tenant\_id | The Azure tenant id for azurerm provider | `string` | `""` | no |
| azurerm-aks\_tags | The tags to associate | `map(string)` | `{}` | no |
| client\_app\_id | Default ad appid | `string` | `"a00a0a00-0a00-0000-a000-0000aaaaaa00"` | no |
| depends\_id | Used to trigger resources | `string` | `""` | no |
| deployment\_type | The deployment type, 1 of target, team, project, base | `string` | `"target"` | no |
| dnsrg | The dns resource group | `string` | `""` | no |
| end\_date | The End Date which the Password is valid until, formatted as a RFC3339 date string (e.g. `2020-01-01T01:02:03Z`). Overrides `years`. | `string` | `""` | no |
| envwhitelistarray | envwhitelist is a computed list of ip addresses to whitelist | `list` | `[]` | no |
| mef\_cluster\_network | The mef cluster network | `string` | `"nonprod-1-int"` | no |
| mef\_cluster\_type | The mef cluster type | `string` | `"data"` | no |
| mef\_deployment\_region | The default deployment region - these need to get mapped to actual regions | `string` | `"emea"` | no |
| mef\_functional\_env | The default deployment region - these need to get mapped to actual regions | `string` | `"nonprod-1"` | no |
| module\_depends\_on | Default dependency declaration | `string` | `""` | no |
| module\_name | The Module name of the module | `string` | `"azurerm-aks-tf12"` | no |
| node\_pools | List of additional node pool objects to be created | `list` | `[]` | no |
| os\_type | The operating system that your terraform client is running on | `string` | `"linux"` | no |
| password | The Password for this Service Principal. | `string` | `""` | no |
| registries | A map of registries you would like to gain access to | `map(string)` | <pre>{<br>  "registry": "id"<br>}</pre> | no |
| registry\_perms | A list of registries you would like to have access to | `list(string)` | `[]` | no |
| role | The name of a built-in Role. | `string` | `"Contributor"` | no |
| server\_app\_id | Default ad appid | `string` | `"a00a0a00-0a00-0000-a000-0000aaaaaa00"` | no |
| server\_app\_secret | Default ad appid | `string` | `"a00a0a00-0a00-0000-a000-0000aaaaaa00"` | no |
| sshRSAPublicKey | ssh-key needed to access kubernetes | `string` | `"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWGW1STMK4p6vDXywL3yUImC1WYrbXPRqRvKzx+WAoM2bEsj4QkCjhm29ef142TVnGT7mw1vzS/8H1MB1jc35QpK9RNcf5zgkwaf9PtmJ3xO7uxZ4pqmhgHx2W24rwrSRYKljnmjwwQkFIPbaoMUx0SHkOuXYo7EnBtOrb8yJvmARso/kFSx7GWFVvL32FxuHycjTYkTRbZ0ZYEQP2s+/3OPsa5xZHmzoFiN40h+uhQUJabhxcjY/umcFuPBhYFvhBWMR0a/YMnX+YzLMsY5hR0BZVDn/aSDF1mJoToRgcJTZlA8PPRpBoQMUI/mDwskOWfJS8K+z3zpKUJc0BJp2j changethis@dbag.com"` | no |
| years | The number of years this service principle is valid for | `number` | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| agent\_secret\_key | Logging workspace private key |
| aks\_cidr | The cidr block used for the cluster |
| aks\_cluster\_name | The operating system to in use on the client |
| aks\_storage\_account | The operating system to in use on the client |
| aks\_vnet\_id | AKS VNet ID |
| aks\_vnet\_name | AKS VNet Name |
| aks\_vnet\_rg | AKS VNet RG |
| azure\_sp\_id | Azure Service Principle Id |
| azure\_sp\_secret | Azure Service Principle Id |
| cl\_resource\_group | The Cluster resource group that this cluster is a part of |
| client\_certificate | Client Cert |
| client\_key | Client Key |
| cluster\_ca\_certificate | Cluster CA cert |
| complete | Indicates if the deployment has completed for aks |
| dns\_service\_ip | The DNS Service IP Address |
| dockerRegistryAdminPassword | Docker admin password |
| dockerRegistryAdminUser | Docker admin user |
| dockerRepoUrl | Docker repo url |
| docker\_bridge\_cidr | The Docker bridge CIDR |
| host | Kubernetes hosts |
| id | Cluster id |
| kube\_admin\_config | Kubernetes Config |
| kube\_config | Kubernetes Config |
| logging\_workspace\_id | Logging workspace id used by oms |
| network\_plugin | The network plugin that is enabled |
| operating\_system | The operating system to in use on the client |
| pod\_cidr | POD CIDR |
| service\_cidr | The Service CIDR |
| storage\_connection\_string | Storage connection string used for helm and storage blobs |
| subnet\_id | The subnet id where this cluster is attached |

