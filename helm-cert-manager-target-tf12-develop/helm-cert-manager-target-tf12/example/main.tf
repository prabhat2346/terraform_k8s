
// helm-cert-manager-target-tf12 module

module "helm-cert-manager-target-tf12" {
  source                                        = "./modules/helm-cert-manager-target-tf12"
  namespace                                     = "ingress-istio"
  cert_namespace                                = "istio-system"
  az_sp_role                                    = "Contributor"
  azure_subscription_alias                      = var.subscription
  az_tenant_id                                  = data.vault_generic_secret.base_secrets.data["tenant_id"]
  az_subscription_id                            = data.vault_generic_secret.base_secrets.data["subscription_id"]
  base_name                                     = var.base_name
  base_target                                   = var.target_name
  helm-cert-manager-kube_config_file            = module.azurerm-aks-tf12.kube_admin_config
  helm-cert-manager-kube_server                 = module.azurerm-aks-tf12.host
  helm-cert-manager-client-certificate-data     = module.azurerm-aks-tf12.client_certificate
  helm-cert-manager-client-key-data             = module.azurerm-aks-tf12.client_key
  helm-cert-manager-certificate-authority-data  = module.azurerm-aks-tf12.cluster_ca_certificate
  module_depends_on                             = module.k8s-istio-system-tf12.istio-ingressgateway-ip
  module_name                                   = "helm-cert-manager-target-tf12"
  deployment_type                               = "target"
  dnsid                                         = data.terraform_remote_state.base.outputs.azure_zone_id
}

