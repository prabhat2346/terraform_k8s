module "azurerm-application-gateway-tf12" {
  source                                 = "./modules/azurerm-application-gateway-tf12"
  namespace                              = terraform.workspace
  azure_subscription_alias               = var.subscription
  azure_subscription_id                  = data.vault_generic_secret.base_secrets.data["subscription_id"]
  resource_group_name                    = module.azurerm-keyvault-acmebot-tf12.resource_group_name
  keyvault_id                            = module.azurerm-keyvault-acmebot-tf12.keyvault_id
  cert_request_terraform_id              = module.azurerm-keyvault-acmebot-tf12.cert_request_terraform_id
  dnsid                                  = data.terraform_remote_state.base.outputs.azure_zone_id
  internal_ip                            = module.k8s-istio-system-tf12.istio-ingressgateway-ip
  azure_client_id                        = data.vault_generic_secret.base_secrets.data["azure_client_id"]
//azurerm-application-gateway-tf12_tags  = "${module.multi-tags.tags}"
}

