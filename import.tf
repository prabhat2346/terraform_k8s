terraform {
 required_providers {
   azurerm = {
     source  = "hashicorp/azurerm"
     version = "=2.40.0"
   }
 }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
 features {}

 subscription_id = "5424b909-d19a-4a13-ac66-4b6670fa4f1c"
 client_id       = "3ab0fca3-169d-4420-9b7e-703af88c12cb"
 client_secret   = "e4Xf-mb3b_iGd15LMw_KT5E~ZB-CB42QO4"
 tenant_id       = "937eee81-4a72-481a-a694-4315abbd5afd"
}
resource "azurerm_virtual_machine_scale_set" "vmss" {
 name                = "vmss-obb-stage-unistad-001"
}


### To import we only need to create the resource : resource "azurerm_virtual_machine_scale_set" "vmss" {
 name                = "vmss-obb-stage-unistad-001"
}
