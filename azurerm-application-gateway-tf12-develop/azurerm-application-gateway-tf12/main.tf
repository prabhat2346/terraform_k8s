
/*
 * <img src="https://raw.githubusercontent.com/dentsuadmin/assets/master/terraform-logo-small.png" width="80" height="80" align="right" />
 *
 * # Azure Application Gateway module
 *
 * ## Overview
 *
 * This module creates an application gateway instance that routes to
 * a private ip address in kubernetes.
 *
 * ## Pre-Requisites
 *
 * * Kubernetes cluster
 * * Peering between the kubernetes cluster and this network
 * * Azure KeyVault Cert module
 * ## Usage
 *
 *
 * ```
 * "azurerm-application-gateway-tf12": {
 *     "enabled": "1",
 *     "azure_location": "westeurope",
 *     "version": "develop",
 *     "env": "dev"
 *   },
 * ```
 *
 */

locals {
  env = lookup(data.external.default.result, "env", "dev")
  project = lookup(data.external.default.result, "project", "EDH" )
  http_settings_name = "${terraform.workspace}-http-settings"
  // Not sure that we still need cprovider since we only use this in azure
  vault_network_path = var.azure_subscription_alias == "" || var.azure_subscription_alias == "devopspoc" ? "secret/target/${terraform.workspace}/${var.cprovider}/iaf_network" : "secret/target/${var.azure_subscription_alias}/${terraform.workspace}/${var.cprovider}/iaf_network"
  vault_ip_address   = var.azure_subscription_alias == "" || var.azure_subscription_alias == "devopspoc" ? "secret/target/${terraform.workspace}/${var.cprovider}/aag_ip" : "secret/target/${var.azure_subscription_alias}/${terraform.workspace}/${var.cprovider}/aag_ip"
  dns_zone_name_split = split("/", var.dnsid)
  // Backend host name (CN)
  platform_domain     = element(local.dns_zone_name_split, length(local.dns_zone_name_split)-1)
  hostnames = formatlist("%s.${local.platform_domain}", split(",", data.external.default.result["hostnames"]))
}

data "external" "default" {
  program = ["bob", "vault", "key", "get", "--subscription=${var.azure_subscription_alias}", "--workspace=${terraform.workspace}", "--run-type=${var.deployment_type}", "--module-name=${var.module_name}"]
}

data "external" "app_id" {
  program = ["${path.module}/scripts/get_object_id.sh", data.azurerm_client_config.current.client_id]
}

resource "null_resource" "moduledep" {
  count     = data.external.default.result["enabled"]

  provisioner "local-exec" {
    command = "echo ${var.resource_group_name} ${var.keyvault_id}"
  }
}

resource "time_sleep" "wait_60_seconds" {
  count = data.external.default.result["enabled"]
  depends_on = [null_resource.moduledep]

  create_duration = "60s"
}

data "azurerm_resource_group" "kv-rg" {
  name = var.resource_group_name
  depends_on = [null_resource.moduledep]
}

data "azurerm_key_vault_certificate" "aag-cert" {
  count        = data.external.default.result["enabled"]
  name         = "wildcard-${replace(local.platform_domain, ".", "-")}"

  key_vault_id = var.keyvault_id

  depends_on   = [
    null_resource.moduledep,
    time_sleep.wait_60_seconds,
    azurerm_key_vault_access_policy.auai,
    azurerm_user_assigned_identity.auai,
    azurerm_key_vault_access_policy.current_access
  ]
}


resource "azurerm_virtual_network" "default" {
  count               = data.external.default.result["enabled"]
  name                = "${terraform.workspace}-network-${local.env}"
  location            = data.azurerm_resource_group.kv-rg.location
  resource_group_name = data.azurerm_resource_group.kv-rg.name
  // TODO: Remove hardcoded value
  address_space       = ["10.3.0.0/16"]
  lifecycle {
    ignore_changes = all
  }
//  DDOS Protection removed to save cost. To enable this, uncomment this
//  and the following block below.

//   ddos_protection_plan {
//    id     = azurerm_network_ddos_protection_plan.iaz.0.id
//    enable = true
//  }
}

//resource "azurerm_network_ddos_protection_plan" "iaz" {
//  count                = data.external.default.result["enabled"]
//  name                = "iaz-protection-plan"
//  location            = data.azurerm_resource_group.kv-rg.location
//  resource_group_name = data.azurerm_resource_group.kv-rg.name
//
//  lifecycle {
//    ignore_changes = all
//  }
//}

resource "azurerm_subnet" "frontend" {
  count                = data.external.default.result["enabled"]
  name                 = "${terraform.workspace}-frontend-${local.env}"
  resource_group_name  = data.azurerm_resource_group.kv-rg.name
  virtual_network_name = azurerm_virtual_network.default.0.name
  address_prefixes     = ["10.3.0.0/24"]
}

resource "azurerm_subnet" "backend" {
  count                = data.external.default.result["enabled"]
  name                 = "${terraform.workspace}-backend-${local.env}"
  resource_group_name  = data.azurerm_resource_group.kv-rg.name
  virtual_network_name = azurerm_virtual_network.default.0.name
  address_prefixes       = ["10.3.2.0/24"]
}

resource "azurerm_public_ip" "default" {
  count               = data.external.default.result["enabled"]
  name                = "${terraform.workspace}-pip"
  resource_group_name = data.azurerm_resource_group.kv-rg.name
  location            = data.azurerm_resource_group.kv-rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  lifecycle {
    ignore_changes = all
  }
}

resource "azurerm_application_gateway" "default" {
  count               = data.external.default.result["enabled"]
  name                = "${terraform.workspace}-appgateway-${local.env}"
  resource_group_name = data.azurerm_resource_group.kv-rg.name
  location            = data.azurerm_resource_group.kv-rg.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "${terraform.workspace}-ip-config-${local.env}"
    subnet_id = azurerm_subnet.frontend.0.id
  }

  frontend_port {
    name = "${terraform.workspace}-frontend-port-80"
    port = 80
  }
  frontend_port {
    name = "${terraform.workspace}-frontend-port-443"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "${terraform.workspace}-frontend-ip-config-${local.env}"
    public_ip_address_id = azurerm_public_ip.default.0.id
  }

  backend_address_pool {
    name = "${terraform.workspace}-beap-${local.env}"
    ip_addresses = [var.internal_ip]
  }

  backend_http_settings {
    name                  = local.http_settings_name
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    host_name             = local.platform_domain
    request_timeout       = 1
    probe_name = "https-probe"
  }

  probe {
    interval                                  = 30
    name                                      = "https-probe"
    path                                      = "/"
    protocol                                  = "HTTPS"
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match {
      status_code = [404]
    }

  }

  http_listener {
      name                           = "${terraform.workspace}-httplistener-${local.env}-https"
      frontend_ip_configuration_name = "${terraform.workspace}-frontend-ip-config-${local.env}"
      frontend_port_name             = "${terraform.workspace}-frontend-port-443"
      protocol                       = "Https"
      ssl_certificate_name           = data.azurerm_key_vault_certificate.aag-cert.0.name
      host_names                      = local.hostnames
  }

  request_routing_rule {
    name                       = "${terraform.workspace}-requestrouting-${local.env}"
    rule_type                  = "Basic"
    http_listener_name         = "${terraform.workspace}-httplistener-${local.env}-https"
    backend_address_pool_name  = "${terraform.workspace}-beap-${local.env}"
    backend_http_settings_name = local.http_settings_name
  }


  ssl_certificate {
    name                = data.azurerm_key_vault_certificate.aag-cert.0.name
    key_vault_secret_id = data.azurerm_key_vault_certificate.aag-cert.0.secret_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.auai.0.id]
  }

  depends_on = [
    azurerm_user_assigned_identity.auai,
    time_sleep.wait_60_seconds
  ]

}

data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "auai" {
  count    = data.external.default.result["enabled"]
  location = data.azurerm_resource_group.kv-rg.location
  resource_group_name = data.azurerm_resource_group.kv-rg.name
  name = "uai-aag"
  tags = data.azurerm_resource_group.kv-rg.tags

  lifecycle {
    ignore_changes = all
  }
}

resource "azurerm_key_vault_access_policy" "auai" {
  count        = data.external.default.result["enabled"]
  key_vault_id = var.keyvault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.auai.0.principal_id

  certificate_permissions = [
    "get"
  ]

  secret_permissions = [
    "get"
  ]

  lifecycle {
    ignore_changes = all
  }
}


// Give the SP that creates the application gateway access to the resource
resource "azurerm_key_vault_access_policy" "current_access" {
  count          = data.external.default.result["enabled"]
  key_vault_id   = var.keyvault_id
  tenant_id      = data.azurerm_client_config.current.tenant_id
  object_id      = data.external.app_id.result["object_id"]

  certificate_permissions = [
    "get"
  ]

  secret_permissions = [
    "get"
  ]

}