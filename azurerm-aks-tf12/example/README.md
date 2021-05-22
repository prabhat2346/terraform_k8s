## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| azure\_subscription\_id | The azure subscription id | string | `""` | no |
| dnsrg | The dns resource group | string | `""` | no |
| registries | A map of the registries that you need access to | map | `<map>` | no |
| registry\_perms | A list of registries that you need access to | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| azure\_sp\_id | Azure Service Principle Id |
| azure\_sp\_secret | Azure Service Principle Id |
| client\_certificate | Client Cert |
| client\_key | Client Key |
| cluster\_ca\_certificate | Cluster CA cert |
| dns\_service\_ip | The DNS Service IP Address |
| dockerRepoUrl | Docker repo url |
| docker\_bridge\_cidr | The Docker bridge CIDR |
| host | Kubernetes hosts |
| id | Cluster id |
| kube\_admin\_config | Kubernetes Config |
| kube\_config | Kubernetes Config |
| network\_plugin | The network plugin that is enabled |
| pod\_cidr | POD CIDR |
| service\_cidr | The Service CIDR |
| storage\_connection\_string | Storage connection string used for helm and storage blobs |
| subnet\_id | The subnet id where this cluster is attached |

