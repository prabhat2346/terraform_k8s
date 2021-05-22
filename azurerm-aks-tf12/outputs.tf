// Indicate that the aKs job has run
output "complete" {
  value       = element(concat(azurerm_kubernetes_cluster.default.*.id, [""]), 0)
  sensitive   = true
  description = "Indicates if the deployment has completed for aks"
}

// Show the Docker repo to use for this target
output "dockerRepoUrl" {
  value = element(
    concat(azurerm_container_registry.default.*.login_server, [""]),
    0,
  )
  sensitive   = true
  description = "Docker repo url"
}

// The Docker Admin user for the registry
output "dockerRegistryAdminUser" {
  value = element(
    concat(azurerm_container_registry.default.*.admin_username, [""]),
    0,
  )
  sensitive   = true
  description = "Docker admin user"
}

// The docker admin password for the registry
output "dockerRegistryAdminPassword" {
  value = element(
    concat(azurerm_container_registry.default.*.admin_password, [""]),
    0,
  )
  sensitive   = true
  description = "Docker admin password"
}

// The connection string to use for blob storage
output "storage_connection_string" {
  value = element(
    concat(
      azurerm_storage_account.default.*.primary_connection_string,
      [""],
    ),
    0,
  )
  sensitive   = true
  description = "Storage connection string used for helm and storage blobs"
}

// Logging workspace id
output "logging_workspace_id" {
  value = element(
    concat(azurerm_log_analytics_workspace.default.*.workspace_id, [""]),
    0,
  )
  sensitive   = true
  description = "Logging workspace id used by oms"
}

// Workspace secret
output "agent_secret_key" {
  value = element(
    concat(
      azurerm_log_analytics_workspace.default.*.primary_shared_key,
      [""],
    ),
    0,
  )
  sensitive   = true
  description = "Logging workspace private key"
}

// Id of the cluster
output "id" {
  //value       = azurerm_kubernetes_cluster.default.id
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].id : "nocluster"
  description = "Cluster id"
  sensitive   = true
}

// Kubernetes config
output "kube_config" {
  //value       = azurerm_kubernetes_cluster.default.kube_config_raw
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].kube_config_raw : "nocluster"
  description = "Kubernetes Config"
  sensitive   = true
}

output "kube_admin_config" {
  //value       = azurerm_kubernetes_cluster.default.kube_admin_config_raw
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].kube_admin_config_raw : "nocluster"
  description = "Kubernetes Config"
  sensitive   = true
}

// output "kube_config1" {
//   value = "${module.kubeconfigfile.stdout}"
//   description = "Kubernetes Config"
//   sensitive   = true
// }

// Client Key
output "client_key" {
  //value       = azurerm_kubernetes_cluster.default.kube_admin_config[0].client_key
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].kube_admin_config[0].client_key : "nocluster"
  description = "Client Key"
  sensitive   = true
}

// Client Cert
output "client_certificate" {
  //value       = azurerm_kubernetes_cluster.default.kube_admin_config[0].client_certificate
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].kube_admin_config[0].client_certificate : "nocluster"
  description = "Client Cert"
  sensitive   = true
}

// Cluster CA certificate
output "cluster_ca_certificate" {
  //value       = azurerm_kubernetes_cluster.default.kube_admin_config[0].cluster_ca_certificate
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].kube_admin_config[0].cluster_ca_certificate : "nocluster"
  description = "Cluster CA cert"
  sensitive   = true
}

// Kubernetes host
output "host" {
  //value       = azurerm_kubernetes_cluster.default.kube_admin_config[0].host
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].kube_admin_config[0].host : "nocluster"
  description = "Kubernetes hosts"
  sensitive   = true
}

// The subnet id where this cluster is attached
output "subnet_id" {
  //value       = azurerm_kubernetes_cluster.default.default_node_pool[0].vnet_subnet_id
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].default_node_pool[0].vnet_subnet_id : "nocluster"
  description = "The subnet id where this cluster is attached"
}

// The network plugin that is enabled
output "network_plugin" {
  //value       = azurerm_kubernetes_cluster.default.network_profile[0].network_plugin
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].network_profile[0].network_plugin : "nocluster"
  description = "The network plugin that is enabled"
}

// The Service CIDR
output "service_cidr" {
  //value       = azurerm_kubernetes_cluster.default.network_profile[0].service_cidr
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].network_profile[0].service_cidr : "nocluster"
  description = "The Service CIDR"
}

// The DNS Service IP Address
output "dns_service_ip" {
  //value       = azurerm_kubernetes_cluster.default.network_profile[0].dns_service_ip
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].network_profile[0].dns_service_ip : "nocluster"
  description = "The DNS Service IP Address"
}

// The Docker bridge CIDR
output "docker_bridge_cidr" {
  //value       = azurerm_kubernetes_cluster.default.network_profile[0].docker_bridge_cidr
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].network_profile[0].docker_bridge_cidr : "nocluster"
  description = "The Docker bridge CIDR"
}

// POD CIDR
output "pod_cidr" {
  //value       = azurerm_kubernetes_cluster.default.network_profile[0].pod_cidr
  value       = data.external.default.result["enableCluster"] == "1" ? azurerm_kubernetes_cluster.default[0].network_profile[0].pod_cidr : "nocluster"
  description = "POD CIDR"
}

// Azure Service Principle ID // Commenting this out for now as we are using the application from devopspoc subscription
output "azure_sp_id" {
  description = "Azure Service Principle Id"
  value       = azuread_service_principal.service_principal[0].id
}

// The azrure sp secret
output "azure_sp_secret" {
  description = "Azure Service Principle Id"
  value       = random_string.password.result
}

output "cl_resource_group" {
  description = "The Cluster resource group that this cluster is a part of"
  value       = "${terraform.workspace}-aks-rg"
}

// The operating system to in use on the client
output "operating_system" {
  value = var.os_type
}

// The operating system to in use on the client
output "aks_cluster_name" {
  value = local.cluster_name
}

// The operating system to in use on the client
output "aks_storage_account" {
  value = local.storage_account_name
}

// The cidr block used for the cluster
output "aks_cidr" {
  value = local.aksCidr
}

// VNet exports
output "aks_vnet_id" {
  value       = azurerm_virtual_network.default[0].id
  description = "AKS VNet ID"
}

output "aks_vnet_name" {
  value       = azurerm_virtual_network.default[0].name
  description = "AKS VNet Name"
}

output "aks_vnet_rg" {
  value       = azurerm_virtual_network.default[0].resource_group_name
  description = "AKS VNet RG"
}
