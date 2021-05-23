// Add the kubernetes provider
provider "kubernetes" {
  version                = "~> 1.11.0"
  host                   = var.helm-cert-manager-kube_server
  client_certificate     = base64decode(var.helm-cert-manager-client-certificate-data)
  client_key             = base64decode(var.helm-cert-manager-client-key-data)
  cluster_ca_certificate = base64decode(var.helm-cert-manager-certificate-authority-data)
  load_config_file       = false
}

