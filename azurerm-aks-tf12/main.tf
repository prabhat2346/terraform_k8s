/**
 * <img src="https://raw.githubusercontent.com/dentsuadmin/assets/master/terraform-logo-small.png" width="80" height="80" align="right" />
 * <img src="https://raw.githubusercontent.com/dentsuadmin/assets/master/Azurelogo.png" width="80" height="80" align="right" />
 *
 * ### This is the azure AKS module for deploying kubernetes clusters
 *
 * This module will setup a kubernetes cluster with all the relavant configurations.
 *
 * Basic 3 node cluster with only default nodepool:
 * ```
 * "azurerm-aks-tf12": {
 *     "agent_count": "3",  // The number of nodes to start with. Must be below min_count and max-count
 *     "min_count": "3",    // The minimum number of pods in scale set
 *     "max_count": "3",    // The maximum number of pods in scale set
 *     "node_pools": [],
 *     "azure_location": "westeurope",
 *     "enableGateway": "0",
 *     "enableMonitoring": "0",
 *     "enableRegistry": "0",
 *     "enableStorageAcc": "1",
 *     "enabled": "1",
 *     "k8sversion": "1.15.12",
 *     "linuxAdminUsername": "linuxadmin",
 *     "version": "0.0.11",
 *     "vm_disk": "250",
 *     "vm_os": "Linux",
 *     "vm_size": "Standard_DS3_v2"
 *   },
 * ```
 *
 * A cluster with a second node pool
 * ```
 * "azurerm-aks-tf12": {
 *     "agent_count": "3",
 *     "min_count": "3",
 *     "max_count": "3",
 *     "node_pools": [
 *       {
 *          "name": "hadoop",
 *          "vm_size": "Standard_E8s_v3",
 *          "min_nodes": "3",
 *          "max_nodes": "3",
 *          "max_pods": "250"  	// Max pods per AKS cluster node. 250 is the maximum value allowed.
 *      }
 *      ],
 *      "azure_location": "westeurope",
 *      "enableGateway": "0",
 *      "enableMonitoring": "0",
 *      "enableRegistry": "0",
 *      "enableStorageAcc": "1",
 *      "enableCluster": "1",
 *      "enabled": "1",
 *      "k8sversion": "1.15.12",
 *      "linuxAdminUsername": "linuxadmin",
 *      "version": "nocluster",
 *      "vm_disk": "250",
 *      "vm_os": "Linux",
 *      "vm_size": "Standard_E4s_v3",
 *      "azure_lock_enabled": "false"
 *    },
 * ```
 */

locals {
  deployment_region = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? lookup(
    data.external.default.result,
    "mef_deployment_region",
    "emea",
  ) : lookup(data.external.default.result, "azure_location", "westeueope")
  mef_functional_env = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? lookup(
    data.external.default.result,
    "mef_functional_env",
    "nonprod-1",
  ) : lookup(data.external.default.result, "azure_location", "westeueope")
  mef_cluster_network = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? lookup(
    data.external.default.result,
    "mef_cluster_network",
    "nonprod-1-int",
  ) : lookup(data.external.default.result, "azure_location", "westeueope")
  network     = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? "secret/project/networks/${local.deployment_region}/azure/${local.mef_functional_env}/${local.mef_cluster_network}/subnets/cluster" : "secret/misc/network/default"
  env_network = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? "secret/project/networks/${local.deployment_region}/azure/${local.mef_functional_env}/${local.mef_cluster_network}/network" : element(concat(azurerm_virtual_network.default.*.id, [""]), 0)
  storage_account_name = replace(
    "${terraform.workspace}saacc",
    "/[^a-zA-Z0-9]/",
    lookup(data.external.default.result, "replace_char", "0"),
  )
  cluster_name         = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? terraform.workspace : "${terraform.workspace}-aks-cluster"
  subnet_count         = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? "1" : "0"
  auto_scaling_vm_type = data.external.default.result["enableAutoScaling"] == "true" || data.external.default.result["enableAutoScaling"] == "1" ? "VirtualMachineScaleSets" : "AvailabilitySet"
  poolname             = data.external.default.result["enableAutoScaling"] || data.external.default.result["enableAutoScaling"] == "1" ? "default" : "linuxpool"
  auto_scale_check     = data.external.default.result["enableAutoScaling"] || data.external.default.result["enableAutoScaling"] == "1" == "true" ? 1 : 0
  vmssCommandLinux     = <<COMMAND
    for i in `az vmss list -g "${data.azurerm_kubernetes_cluster.lookup[0].node_resource_group}" --query "[].name" --output tsv`;
    do az vmss list-instances -g "${data.azurerm_kubernetes_cluster.lookup[0].node_resource_group}" --name $i --query "[].id" --output tsv | \
    az vmss run-command invoke -g "${data.azurerm_kubernetes_cluster.lookup[0].node_resource_group}" --ids @- --command-id RunShellScript --scripts "echo fs.inotify.max_user_watches=2048576 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p";
    done
    COMMAND

  vmssCommandWindows = <<COMMAND
    foreach ($i in &az vmss list -g "${data.azurerm_kubernetes_cluster.lookup[0].node_resource_group}" --query "[].name" --output tsv) {
      $ids = &az vmss list-instances -g "${data.azurerm_kubernetes_cluster.lookup[0].node_resource_group}" --name $i --query "[].id" --output tsv
      az vmss run-command invoke --ids $ids --command-id RunShellScript --scripts "echo fs.inotify.max_user_watches=2048576 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p"
    }
    COMMAND

  vmssCommand = "${var.os_type == "windows" ? local.vmssCommandWindows : local.vmssCommandLinux}"

  vmCommand = <<COMMAND
    az vm run-command invoke -g "${data.azurerm_kubernetes_cluster.lookup[0].node_resource_group}" -n "${data.external.default.result["agent_count"]}" --command-id RunShellScript --scripts "echo fs.inotify.max_user_watches=2048576 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p"
    COMMAND

  setCommand = "${local.auto_scaling_vm_type == "VirtualMachineScaleSets" ? local.vmssCommand : local.vmCommand}"

  aksCidr = lookup(data.external.default.result, "aks_cidr", "10.1.0.0/16")
  // If hte aksSubnet is not provided, use the aks cidr range
  aksSubnet          = lookup(data.external.default.result, "aks_subnet", local.aksCidr)
  enable_soft_delete = data.external.default.result["soft_delete_in_days"] == 0 || data.external.default.result["soft_delete_in_days"] == "0" ? {} : { key = data.external.default.result["soft_delete_in_days"] }
  vault_network_path = var.azure_subscription_alias == "" || var.azure_subscription_alias == "devopspoc" ? "secret/target/${terraform.workspace}/${var.cprovider}/aks_network" : "secret/target/${var.azure_subscription_alias}/${terraform.workspace}/${var.cprovider}/aks_network"

}

// Setup external data reference from bob.
data "external" "default" {
  program = ["bob", "vault", "key", "get", "--subscription=${var.azure_subscription_alias}", "--workspace=${terraform.workspace}", "--run-type=${var.deployment_type}", "--module-name=${var.module_name}"]
}

data "vault_generic_secret" "new_subnets" {
  // count = "${lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? "1" : "0"}"
  path = local.network
}

data "vault_generic_secret" "new_network" {
  count = lookup(data.external.default.result, "enableNewConfig", 1)
  path  = local.env_network
}

// Get the network ids from vault
data "vault_generic_secret" "network" {
  count = 0
  path  = local.network
}

// Create random password for service principle.
resource "random_string" "password" {
  length = 32
}

// Create random password for service principle.
resource "random_string" "aadaksServer" {
  length = 32
}

// Create random key for registry.
resource "random_string" "registry" {
  length      = 2
  min_numeric = 1
  special     = false
  upper       = false
}

// Create random id
resource "random_id" "name" {
  byte_length = 16
  prefix      = "terraform"
}

// Azure Resource Group
resource "azurerm_resource_group" "default" {
  count      = 1
  name       = "${terraform.workspace}-aks-rg"
  location   = data.external.default.result["azure_location"]
  depends_on = []
  tags       = var.azurerm-aks_tags
}

// Create active directory application
//NOCLUST
resource "azuread_application" "service_principal" {
  count                      = data.external.default.result["enableCluster"]
  name                       = "${terraform.workspace}rootSpAd"
  homepage                   = "https://${terraform.workspace}rootSphome"
  identifier_uris            = [local.IdentifierUri]
  reply_urls                 = ["https://${terraform.workspace}rootSpReply"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true

  lifecycle {
    ignore_changes = all
  }

  depends_on = [
    azurerm_resource_group.default,
    azurerm_storage_account.default,
  ]

  provisioner "local-exec" {
    command = "sleep 60"
    interpreter = [
      local.shellInterpereter,
      local.commandOpts,
    ]
  }
}

// Create the service principle
//NOCLUST
resource "azuread_service_principal" "service_principal" {
  count          = data.external.default.result["enableCluster"]
  application_id = azuread_application.service_principal[0].application_id

  lifecycle {
    ignore_changes = all
  }

  depends_on = [
    azurerm_resource_group.default,
    azurerm_storage_account.default,
    azuread_application.service_principal,
  ]
}

// Set the password
//NOCLUST
resource "azuread_service_principal_password" "service_principal_spn_pwd" {
  count                = data.external.default.result["enableCluster"]
  service_principal_id = azuread_service_principal.service_principal[0].id
  value                = coalesce(var.password, random_string.password.result)
  end_date = coalesce(
    var.end_date,
    timeadd(timestamp(), "${var.years * 24 * 365}h"),
  )

  lifecycle {
    ignore_changes = all
  }

  depends_on = [
    azuread_application.service_principal,
    azuread_service_principal.service_principal,
  ]
}

// Add role to service principle.
//NOCLUST
resource "azurerm_role_assignment" "service_principal" {
  count                = data.external.default.result["enableCluster"]
  scope                = element(azurerm_resource_group.default.*.id, count.index)
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.service_principal[0].id

  depends_on = [
    azurerm_resource_group.default,
    azurerm_storage_account.default,
  ]
}

// Add Service principle to docker registry.
//NOCLUST
resource "azurerm_role_assignment" "docker_registry" {
  count                = data.external.default.result["enableRegistry"] == "0" || data.external.default.result["enableCluster"] == "0" ? "0" : "1"
  scope                = element(azurerm_container_registry.default.*.id, count.index)
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.service_principal[0].id

  depends_on = [
    azuread_application.service_principal,
    azurerm_resource_group.default,
    azurerm_storage_account.default,
    azurerm_container_registry.default,
  ]
}

// Add Service principle group to docker registry (ASG-GDO-CLUSTERS).
resource "azurerm_role_assignment" "docker_reg_asg" {
  count                = data.external.default.result["enableRegistry"]
  scope                = element(azurerm_container_registry.default.*.id, count.index)
  role_definition_name = "Reader"
  principal_id         = "b3e6afb0-4d6d-4031-8c9d-815cab827bdc"

  depends_on = [
    azurerm_resource_group.default,
    azurerm_container_registry.default,
  ]
}

// Add Service principle group to docker registry (ASG-GDO-PIPELINE).
resource "azurerm_role_assignment" "docker_reg_pipe" {
  count                = data.external.default.result["enableRegistry"]
  scope                = element(azurerm_container_registry.default.*.id, count.index)
  role_definition_name = "Contributor"
  principal_id         = "4f775f55-c3e9-4632-9a76-b13596d1886d"

  depends_on = [
    azurerm_resource_group.default,
    azurerm_container_registry.default,
  ]
}

// Add role assignments to docker registries
//NOCLUST
resource "azurerm_role_assignment" "registries" {
  count = data.external.default.result["enableCluster"] == "0" ? "0" : length(var.registry_perms)
  scope = lookup(
    var.registries,
    element(var.registry_perms, count.index),
    "none",
  ) // "${element(var.registries, count.index)}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.service_principal[0].id

  depends_on = [
    azuread_application.service_principal,
    azurerm_resource_group.default,
    azurerm_storage_account.default,
    azurerm_container_registry.default,
  ]
}

// Add Service principle to dns
//NOCLUST
resource "azurerm_role_assignment" "dns_role" {
  count                = data.external.default.result["enableCluster"]
  scope                = var.dnsrg
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.service_principal[0].id

  depends_on = [
    azuread_application.service_principal,
    azurerm_resource_group.default,
    azurerm_storage_account.default,
    azurerm_container_registry.default,
  ]
}

// Add network assignment for external LB to READ from networks
//NOCLUST
resource "azurerm_role_assignment" "network_role" {
  //count        = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? "1" : "0"
  count        = lookup(data.external.default.result, "enableNewConfig", "0") == "0" || data.external.default.result["enableCluster"] == "0" ? "0" : "1"
  principal_id = azuread_service_principal.service_principal[0].id
  scope        = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? data.vault_generic_secret.new_network.0.data[lookup(data.external.default.result, "mef_cluster_type", "data")] : element(concat(azurerm_virtual_network.default.*.id, [""]), 0)
  depends_on = [
    azuread_application.service_principal,
    azurerm_resource_group.default,
    azurerm_storage_account.default,
    azurerm_container_registry.default,
  ]
}

// Create Storage Account
resource "azurerm_storage_account" "default" {

  name = replace(
    "${terraform.workspace}saacc",
    "/[^a-zA-Z0-9]/",
    lookup(data.external.default.result, "replace_char", "0"),
  )
  count                    = data.external.default.result["enableStorageAcc"]
  resource_group_name      = "${terraform.workspace}-aks-rg"
  location                 = element(azurerm_resource_group.default.*.location, count.index)
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"

  dynamic "blob_properties" {
    for_each = local.enable_soft_delete
    content {
      delete_retention_policy {
        days = blob_properties.value
      }
    }
  }

  depends_on = [azurerm_resource_group.default]
}

// Create routing table
resource "azurerm_route_table" "default" {
  // If not deploying a cluster, or if have specified no gateway, then don't deploy the route
  count               = lookup(data.external.default.result, "enableGateway", "0") == "0" || lookup(data.external.default.result, "enableCluster", "0") == "0" ? "0" : "1"
  name                = "${terraform.workspace}-routetable"
  location            = element(azurerm_resource_group.default.*.location, count.index)
  resource_group_name = element(azurerm_resource_group.default.*.name, count.index)

  route {
    name                   = "default"
    address_prefix         = "10.100.0.0/14"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.1.1"
  }
}

// Create the virtual network
resource "azurerm_virtual_network" "default" {
  count               = data.external.default.result["enableCluster"]
  name                = "${terraform.workspace}-network"
  location            = azurerm_resource_group.default.0.location
  resource_group_name = azurerm_resource_group.default.0.name
  address_space       = [local.aksCidr]
  lifecycle {
    ignore_changes = all
  }
}

// Enable the azure subnet for non zoned clusters
resource "azurerm_subnet" "default" {
  // Don't deploy if we are deploying in zoned, or we are not deploying a cluster
  //count                = lookup(data.external.default.result, "enableNewConfig", "0") == "0" ? "1" : "0"
  count                = lookup(data.external.default.result, "enableNewConfig", "0") == "1" || lookup(data.external.default.result, "enableCluster", "0") == "0" ? "0" : "1"
  name                 = "${terraform.workspace}subnet"
  resource_group_name  = element(azurerm_resource_group.default.*.name, count.index)
  address_prefix       = local.aksSubnet
  virtual_network_name = azurerm_virtual_network.default[0].name
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
  lifecycle {
    ignore_changes = all
  }
}

// Associate the Gateway with the routing table
resource "azurerm_subnet_route_table_association" "default" {
  //count          = data.external.default.result["enableGateway"]
  // If no gateway enabled, or no cluster being deployed, then don;t do this
  count          = lookup(data.external.default.result, "enableGateway", "0") == "0" || lookup(data.external.default.result, "enableCluster", "0") == "0" ? "0" : "1"
  subnet_id      = azurerm_subnet.default[0].id
  route_table_id = element(concat(azurerm_route_table.default.*.id, [""]), count.index)
}

// Enable the storage container
resource "azurerm_storage_container" "default" {
  name = replace(terraform.workspace, "/[^a-zA-Z0-9]/", 0)

  count = data.external.default.result["enableStorageAcc"]

  storage_account_name  = element(azurerm_storage_account.default.*.name, count.index)
  container_access_type = "private"

  depends_on = [
    azurerm_resource_group.default,
    azurerm_storage_account.default,
  ]
}

// Enable the docker registry for this target
resource "azurerm_container_registry" "default" {
  name = replace(
    "${terraform.workspace}${random_string.registry.result}rg",
    "/[^a-zA-Z0-9]/",
    1,
  )
  count               = data.external.default.result["enableRegistry"]
  resource_group_name = "${terraform.workspace}-aks-rg"
  location            = element(azurerm_resource_group.default.*.location, count.index)
  admin_enabled       = true
  sku                 = "Premium"

  // The following is not a valid option for a managed sku
  //storage_account_id  = "${element(azurerm_storage_account.default.*.id, count.index)}"

  depends_on = [azurerm_resource_group.default]
  tags       = var.azurerm-aks_tags
}

// Create a a var with the docker registry id
resource "vault_generic_secret" "docker" {
  count = data.external.default.result["enableRegistry"]
  path  = local.vaultPathDocker

  data_json = <<EOT
{
  "url":   "${element(
  concat(azurerm_container_registry.default.*.login_server, [""]),
  0,
)}",
  "id": "${element(concat(azurerm_container_registry.default.*.id, [""]), 0)}"
}
EOT

}

// Write the secret for anchore use
resource "vault_generic_secret" "anchore_registries" {
  count = data.external.default.result["enableRegistry"]
  path = "secret/project/docker/registries/${element(
    concat(azurerm_container_registry.default.*.admin_username, [""]),
    0,
  )}"

  data_json = <<EOT
{
  "DOCKER_LOGIN_SERVER": "${element(
  concat(azurerm_container_registry.default.*.login_server, [""]),
  0,
  )}",
  "DOCKER_USERNAME": "${element(
  concat(azurerm_container_registry.default.*.admin_username, [""]),
  0,
  )}",
  "DOCKER_PASSWORD": "${element(
  concat(azurerm_container_registry.default.*.admin_password, [""]),
  0,
)}"
}
EOT

}

// Write the secret for anchore account (which matches the docker username/password)
resource "vault_generic_secret" "anchore_registries_userpass" {
  count = data.external.default.result["enableRegistry"]
  path = "secret/project/docker/registries/${element(
    concat(azurerm_container_registry.default.*.admin_username, [""]),
    0,
  )}/anchore"

  data_json = <<EOT
{
  "USERNAME": "${element(
  concat(azurerm_container_registry.default.*.admin_username, [""]),
  0,
  )}",
  "PASSWORD": "${element(
  concat(azurerm_container_registry.default.*.admin_password, [""]),
  0,
)}"
}
EOT

}

// Add the anchore account
// Post to /accounts creates an acccount
resource "restapi_object" "anchore_account" {
  count     = data.external.default.result["enableRegistry"] == "1" && lookup(data.external.default.result, "anchoreExists", "0") == "0" ? "1" : "0"
  path      = "/accounts"
  object_id = "created_at"
  data = "{ \"name\": \"${element(
    concat(azurerm_container_registry.default.*.admin_username, [""]),
    0,
  )}\" }"
}

// Add the anchore user
// Post to /accounts/{accountname}/users creates a user
resource "restapi_object" "anchore_user" {
  count = data.external.default.result["enableRegistry"] == "1" && lookup(data.external.default.result, "anchoreExists", "0") == "0" ? "1" : "0"
  path = "/accounts/${element(
    concat(azurerm_container_registry.default.*.admin_username, [""]),
    0,
  )}/users"
  data = "{ \"username\": \"${element(
    concat(azurerm_container_registry.default.*.admin_username, [""]),
    0,
    )}\", \"password\": \"${element(
    concat(azurerm_container_registry.default.*.admin_password, [""]),
    0,
  )}\" }"
  object_id  = "created_at"
  depends_on = [restapi_object.anchore_account]
}

// Create anchore registries
// Post request to /registries
// Uses basic auth using the created username and password from restapi.anchore_account
// basic auth = base64encode(username:password)
// payload = {'registry': registry, 'registry_user': registry_user,
//            'registry_pass': registry_pass, 'registry_type': registry_type,
//              'registry_verify':verify, 'registry_name':registry_name}
resource "null_resource" "anchore_registries" {
  count = data.external.default.result["enableRegistry"] == "1" && lookup(data.external.default.result, "anchoreExists", "0") == "0" ? "1" : "0"
  provisioner "local-exec" {
    command = <<COMMAND
    curl --location --request POST '${var.anchore_url}/registries/' --header 'Content-Type: application/json' --header 'Authorization: Basic ${base64encode(join(":", azurerm_container_registry.default.*.admin_username, azurerm_container_registry.default.*.admin_password))}' --data-raw '{ "registry": "${element(concat(azurerm_container_registry.default.*.login_server, [""]), 0)}", "registry_user": "${element(concat(azurerm_container_registry.default.*.admin_username, [""]), 0)}", "registry_pass": "${element(concat(azurerm_container_registry.default.*.admin_password, [""]), 0)}", "registry_type": "docker_v2", "registry_verify": ${true}, "registry_name": "${element(concat(azurerm_container_registry.default.*.name, [""]), 0)}" }'
COMMAND
    interpreter = [
      local.shellInterpereter,
      local.commandOpts,
    ]

  }
  depends_on = [restapi_object.anchore_user]
}

// Create monitoring and logging workspace
resource "azurerm_log_analytics_workspace" "default" {
  // Only deploy if we are deploying a cluster
  //count = data.external.default.result["enableCluster"] == "0" || data.external.default.result["enableMonitoring"] == "0" ? "0" : "1"
  count = data.external.default.result["enableCluster"] == "0" ? "0" : "1"
  //  count               = 0
  name                = "k8s-workspace-${terraform.workspace}"
  location            = element(azurerm_resource_group.default.*.location, count.index)
  resource_group_name = element(azurerm_resource_group.default.*.name, count.index)
  sku                 = "PerGB2018"
  tags                = var.azurerm-aks_tags
  retention_in_days   = 30
  depends_on          = [azurerm_resource_group.default]
}

resource "azurerm_management_lock" "rg-delete-lock" {
  count      = data.external.default.result["azure_lock_enabled"] == "1" || data.external.default.result["azure_lock_enabled"] == "true" ? 1 : 0
  name       = "rg-delete-lock"
  scope      = azurerm_resource_group.default[0].id
  lock_level = "CanNotDelete"
  notes      = "Items can't be deleted in this resource group"

  depends_on = [azurerm_resource_group.default]
}

// Enable Logging
resource "azurerm_log_analytics_solution" "default" {
  // NOCLUST
  count = data.external.default.result["enableCluster"] == "0" || data.external.default.result["enableMonitoring"] == "0" ? "0" : "1"
  //count                 = data.external.default.result["enableMonitoring"]
  solution_name         = "Containers"
  location              = element(azurerm_resource_group.default.*.location, count.index)
  resource_group_name   = element(azurerm_resource_group.default.*.name, count.index)
  workspace_resource_id = element(azurerm_log_analytics_workspace.default.*.id, count.index)
  workspace_name        = "k8s-workspace-${terraform.workspace}"

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Containers"
  }
}

// Create the Kubernetes cluster
resource "azurerm_kubernetes_cluster" "default" {
  // NOCLUST
  count               = data.external.default.result["enableCluster"]
  name                = local.cluster_name
  location            = azurerm_resource_group.default.0.location
  resource_group_name = azurerm_resource_group.default.0.name
  dns_prefix          = terraform.workspace
  kubernetes_version  = data.external.default.result["k8sversion"]

  // Setup the linux admin user and ssh key
  linux_profile {
    admin_username = coalesce(
      data.external.default.result["linuxAdminUsername"],
      replace("${terraform.workspace}linuxadmin", "/[^a-zA-Z0-9]/", 1),
    )

    ssh_key {
      key_data = var.sshRSAPublicKey
    }
  }


  // Setup the Agent pool for the cluster.
  default_node_pool {
    name                = data.external.default.result["enableAutoScaling"] == "true" ? "default" : "${lower(data.external.default.result["vm_os"])}pool"
    node_count          = data.external.default.result["agent_count"]
    vm_size             = data.external.default.result["vm_size"]
    os_disk_size_gb     = data.external.default.result["vm_disk"]
    vnet_subnet_id      = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? data.vault_generic_secret.new_subnets.data[lookup(data.external.default.result, "mef_cluster_type", "data")] : element(concat(azurerm_subnet.default.*.id, [""]), 0)
    enable_auto_scaling = data.external.default.result["enableAutoScaling"]
    type                = local.auto_scaling_vm_type
    min_count           = data.external.default.result["min_count"]
    max_count           = data.external.default.result["max_count"]
    max_pods            = data.external.default.result["max_pods"]
    // Note - AKS requires lowercase nodepool labels
    node_labels = { "nodepool" : "default" }
  }

  // Assign the service principle to the cluster
  service_principal {
    client_id     = azuread_application.service_principal[0].application_id
    client_secret = random_string.password.result
  }

  tags = var.azurerm-aks_tags
  //  TODO Figure out where this goes
  //  os_type         = data.external.default.result["vm_os"]

  // Enable Monitoring
  addon_profile {
    oms_agent {
      enabled                    = data.external.default.result["enableMonitoring"] == "1" ? true : false
      log_analytics_workspace_id = azurerm_log_analytics_workspace.default.0.id
    }
  }

  api_server_authorized_ip_ranges = var.envwhitelistarray

  // Enable RBAC
  role_based_access_control {
    azure_active_directory {
      client_app_id     = var.client_app_id
      server_app_id     = var.server_app_id
      server_app_secret = var.server_app_secret
    }

    enabled = true
  }

  lifecycle {
    ignore_changes = all
  }

  // Setup the network plugin
  network_profile {
    network_plugin = "azure"
  }

  // Setup dependencies
  depends_on = [
    azurerm_resource_group.default,
    azurerm_storage_account.default,
    azurerm_storage_container.default,
    azurerm_role_assignment.service_principal,
  ]
}

resource "azurerm_kubernetes_cluster_node_pool" "additonal" {
  // NOCLUST
  count                 = length(var.node_pools) == "0" || data.external.default.result["enableCluster"] == "0" ? "0" : length(var.node_pools)
  kubernetes_cluster_id = azurerm_kubernetes_cluster.default[0].id

  name      = element(var.node_pools, count.index)["name"]
  vm_size   = element(var.node_pools, count.index)["vm_size"]
  min_count = element(var.node_pools, count.index)["min_nodes"]
  max_count = element(var.node_pools, count.index)["max_nodes"]
  // Note - AKS requires lowercase nodepool labels
  node_labels = { "nodepool" : element(var.node_pools, count.index)["name"] }
  node_taints = [lookup(element(var.node_pools, count.index), "node_taints", "")] // Set taints, with empty string if not provided

  max_pods            = element(var.node_pools, count.index)["max_pods"]
  vnet_subnet_id      = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? data.vault_generic_secret.new_subnets.data[lookup(data.external.default.result, "mef_cluster_type", "data")] : element(concat(azurerm_subnet.default.*.id, [""]), 0)
  enable_auto_scaling = true
  os_disk_size_gb     = tonumber(lookup(element(var.node_pools, count.index), "vm_disk", 128))
}

// Get the resource group of where the nodes are created
data "azurerm_kubernetes_cluster" "lookup" {
  // NOCLUST
  count               = data.external.default.result["enableCluster"]
  name                = lookup(data.external.default.result, "enableNewConfig", "0") == "1" ? terraform.workspace : "${terraform.workspace}-aks-cluster"
  resource_group_name = azurerm_resource_group.default.0.name

  depends_on = [
    azurerm_resource_group.default,
    azurerm_storage_account.default,
    azurerm_storage_container.default,
    azurerm_role_assignment.service_principal,
    azurerm_kubernetes_cluster.default,
  ]
}

// Get a list of the vms
resource "local_file" "getvms" {
  // NOCLUST
  count    = data.external.default.result["enableCluster"]
  content  = local.templatefile
  filename = local.templatePath

  provisioner "local-exec" {
    command = local.templatecommand
  }
}


// Add the sysctl limits.
resource "null_resource" "aks-run-command" {
  // NOCLUST
  count = data.external.default.result["agent_count"] == "0" || data.external.default.result["enableCluster"] == "0" ? "0" : data.external.default.result["agent_count"]

  provisioner "local-exec" {
    command = local.setCommand

    interpreter = [
      local.shellInterpereter,
      local.commandOpts,
    ]
  }

  depends_on = [azurerm_kubernetes_cluster.default]
}
