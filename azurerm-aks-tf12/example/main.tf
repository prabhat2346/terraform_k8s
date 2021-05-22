// azurerm-aks module
module "azurerm-aks-tf12" {
  source                   = "./modules/azurerm-aks-tf12"
  azure_subscription_id    = data.vault_generic_secret.base_secrets.data["subscription_id"]
  sshRSAPublicKey          = module.common-ssh-key-tf12.public_ssh
  dnsrg                    = data.terraform_remote_state.base.outputs.azure_dns_resource_group
  registries               = var.registries
  registry_perms           = var.registry_perms
  azure_subscription_alias = var.subscription
  os_type                  = var.os
  client_app_id = lookup(
    data.vault_generic_secret.base_secrets.data,
    "client_app_id",
    var.client_app_id,
  )
  server_app_id = lookup(
    data.vault_generic_secret.base_secrets.data,
    "server_app_id",
    var.server_app_id,
  )
  server_app_secret = lookup(
    data.vault_generic_secret.base_secrets.data,
    "server_app_secret",
    var.server_app_secret,
  )
  azurerm-aks_tags = module.multi-tags-tf12.tags
  azure_env        = var.azure_env
  anchore_url = lookup(
    data.vault_generic_secret.anchore_account.data,
    "ANCHORE_CLI_URL",
    "https://anchore.saas.gcp.gdp-devops.gdpdentsu.net/v1",
  )
  anchore_user = lookup(
    data.vault_generic_secret.anchore_account.data,
    "ANCHORE_CLI_USER",
    var.anchore_user,
  )
  anchore_password = lookup(
    data.vault_generic_secret.anchore_account.data,
    "ANCHORE_CLI_PASS",
    var.anchore_password,
  )
  anchore_sslverify = lookup(
    data.vault_generic_secret.anchore_account.data,
    "ANCHORE_CLI_SSL_VERIFY",
    var.anchore_sslverify,
  )
  azure_client_id     = data.vault_generic_secret.base_secrets.data["azure_client_id"]
  azure_client_secret = data.vault_generic_secret.base_secrets.data["azure_client_secret"]
  azure_tenant_id     = data.vault_generic_secret.base_secrets.data["azure_tenant_id"]
  envwhitelistarray   = var.envwhitelistarray
  // Node Pools
  node_pools    = var.azurerm-aks-tf12_node_pools

}
