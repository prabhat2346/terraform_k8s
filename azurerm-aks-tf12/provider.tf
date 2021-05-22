// Declare the vault provider
provider "vault" {
}

// Force the azurerm version on this
provider "azurerm" {
  version         = ">= 2.1.0"
  environment     = var.azure_env
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  features {}
}

provider "restapi" {
  uri                   = var.anchore_url
  debug                 = true
  write_returns_object  = true
  create_returns_object = true
  username              = var.anchore_user
  password              = var.anchore_password
  insecure              = false
}
