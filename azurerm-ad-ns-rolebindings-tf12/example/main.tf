module "azurerm-ad-ns-rolebindings-tf12" {
  source                   = "./modules/azurerm-ad-ns-rolebindings-tf12"
  azure_subscription_alias = var.subscription
  module_name              = "azurerm-ad-ns-rolebindings-tf12"
  base_target              = var.base_target
  aksRG                    = "${var.base_target}-aks-rg"
  az_subscription_id       = data.vault_generic_secret.base_secrets.data["subscription_id"]
}