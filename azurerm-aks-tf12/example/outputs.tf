// Indicate that the aKs job has run

// Show the Docker repo to use for this target
output "dockerRepoUrl" {
  value       = module.azurerm-aks-tf12.dockerRepoUrl
  sensitive   = true
  description = "Docker repo url"
}

// The connection string to use for blob storage
output "storage_connection_string" {
  value       = module.azurerm-aks-tf12.storage_connection_string
  sensitive   = true
  description = "Storage connection string used for helm and storage blobs"
}

// Id of the cluster
output "id" {
  value       = module.azurerm-aks-tf12.id
  description = "Cluster id"
  sensitive   = true
}

// The Docker Admin user for the registry
output "dockerRegistryAdminUser" {
  value       = module.azurerm-aks-tf12.dockerRegistryAdminUser
  sensitive   = true
  description = "Docker admin user"
}

// The docker admin password for the registry
output "dockerRegistryAdminPassword" {
  value       = module.azurerm-aks-tf12.dockerRegistryAdminPassword
  sensitive   = true
  description = "Docker admin password"
}

// Kubernetes config
//output "kube_config1" {
//  value = "${module.azurerm-aks-tf12.kube_config}"
//  description = "Kubernetes Config"
//  sensitive   = true
//}

// Kubernetes config
output "kube_config" {
  value       = module.azurerm-aks-tf12.kube_config
  description = "Kubernetes Config"
  sensitive   = true
}

// Kubernetes config
output "kube_admin_config" {
  value       = module.azurerm-aks-tf12.kube_admin_config
  description = "Kubernetes Config"
  sensitive   = true
}

// Client Key
output "client_key" {
  value       = module.azurerm-aks-tf12.client_key
  description = "Client Key"
  sensitive   = true
}

// Client Cert
output "client_certificate" {
  value       = module.azurerm-aks-tf12.client_certificate
  description = "Client Cert"
  sensitive   = true
}

// Cluster CA certificate
output "cluster_ca_certificate" {
  value       = module.azurerm-aks-tf12.cluster_ca_certificate
  description = "Cluster CA cert"
  sensitive   = true
}

// Kubernetes host
output "host" {
  value       = module.azurerm-aks-tf12.host
  description = "Kubernetes hosts"
  sensitive   = true
}

// The subnet id where this cluster is attached
output "subnet_id" {
  value       = module.azurerm-aks-tf12.subnet_id
  description = "The subnet id where this cluster is attached"
}

// The network plugin that is enabled
output "network_plugin" {
  value       = module.azurerm-aks-tf12.network_plugin
  description = "The network plugin that is enabled"
}

// The Service CIDR
output "service_cidr" {
  value       = module.azurerm-aks-tf12.service_cidr
  description = "The Service CIDR"
}

// The DNS Service IP Address
output "dns_service_ip" {
  value       = module.azurerm-aks-tf12.dns_service_ip
  description = "The DNS Service IP Address"
}

// The Docker bridge CIDR
output "docker_bridge_cidr" {
  value       = module.azurerm-aks-tf12.docker_bridge_cidr
  description = "The Docker bridge CIDR"
}

// POD CIDR
output "pod_cidr" {
  value       = module.azurerm-aks-tf12.pod_cidr
  description = "POD CIDR"
}

output "azure_sp_id" {
  description = "Azure Service Principle Id"
  value       = module.azurerm-aks-tf12.azure_sp_id
}

output "azure_sp_secret" {
  description = "Azure Service Principle Id"
  value       = module.azurerm-aks-tf12.azure_sp_secret
}

output "cluster_resource_group" {
  description = "The Cluster resource group that this cluster is a part of"
  value       = module.azurerm-aks-tf12.cl_resource_group
}

// The operating system to in use on the client
output "aks_cluster_name" {
  value = module.azurerm-aks-tf12.aks_cluster_name
}

// The operating system to in use on the client
output "aks_storage_account" {
  value = module.azurerm-aks-tf12.aks_storage_account
}

