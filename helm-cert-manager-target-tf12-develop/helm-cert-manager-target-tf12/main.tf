/**
 * <img src="https://raw.githubusercontent.com/dentsuadmin/assets/master/terraform-logo-small.png" width="80" height="80" align="right" />
 * <img src="https://avatars3.githubusercontent.com/u/13183983?s=200&v=4" width="80" height="80" align="right" />
 * <img src="https://helm.sh/assets/images/helm-logo.svg" width="80" height="80" align="right" />
 *
 *
 *
 * #Cert-manager-target Terraform module
 *
 * ## Overview
 * 
 * This module is similar to the original helm-cert-manager-tf12 module however it is deployed at <br>
 * Target level and is intended for use with the new "next generation" IAZ model. Typically this is<br> 
 * used with Istio and therefore by default the certificate object is created in the istio-system <br>
 * namespace for use by the envoy based istio-ingressgateway.
 * 
 * 
 * ## Pre-Requisites
 * 
 * A Kubernetes cluster
 * Jetstack helm repo added on your local machine: 
 * 
 * ```
 * helm repo add jetstack https://charts.jetstack.io
 * ```
 * 
 * ## Usage
 * 
 * An example deployment:
 * 
 * ```
 * "helm-cert-manager-tf12": {
 *      "az_email": "2469339d.aegisdentsunetwork.onmicrosoft.com@emea.teams.ms",
 *       "enabled": "1",
 *       "version": "DEVTOOL-870"
 *     }
 * ```
 * 
 * ## Usage
 * ### NOTE: The module now handles the certificate creation; however here is how it can be done manually.
 * ### Creating a default wildcard cert for istio-ingressgateway
 * 
 * If Istio has been deployed using the Dentsu DevOps k8s-istio-system-tf12 module, it will look for a certificate secret in the istio-system namespace called `TBC`. 
 * 
 * 
 * ## Known issues/limitations
 * 
 * * TBC
 * 
 * 
**/

// ---------------------------------------------------------------------------
// Get data from vault
// ---------------------------------------------------------------------------
data "external" "default" {
  program = ["bob", "vault", "key", "get", "--subscription=${var.azure_subscription_alias}", "--workspace=${terraform.workspace}", "--run-type=${var.deployment_type}", "--module-name=${var.module_name}"]
}


// ---------------------------------------------------------------------------
// Set up locals
// ---------------------------------------------------------------------------
locals {
  kubeconfig       = "/tmp/${terraform.workspace}-aks-cluster"
  kubeconfig-home  = pathexpand("~/.kube-bob/${terraform.workspace}")
  wildcardSSLcrt   = "/tmp/${terraform.workspace}-wildcard-ssl-crt.yaml"
  vaultCertManager = var.azure_subscription_alias == "" || var.azure_subscription_alias == "devopspoc" ? "secret/${var.deployment_type}/${terraform.workspace}/azure/cert-manager-sp" : "secret/${var.deployment_type}/${var.azure_subscription_alias}/${terraform.workspace}/azure/cert-manager-sp"
  vaultbasepath    = "secret/accounts/${var.subscription}/azure"
  hostedZone       = format("%s.%s.%s","az",var.base_name,"gdpdentsu.net")
  dns_zone_name_split = split("/", var.dnsid)
  platform_domain     = element(local.dns_zone_name_split, length(local.dns_zone_name_split)-1)
  issuerManifest   = "/tmp/${terraform.workspace}-ClusterIssuer.yaml"
}


// ---------------------------------------------------------------------------
// Create kube config - TODO - fix the fact that I've created in two places
// ---------------------------------------------------------------------------
resource "local_file" "kube_config" {
  count             = data.external.default.result["enabled"]
  content           = var.helm-cert-manager-kube_config_file
  filename          = local.kubeconfig
}

resource "null_resource" "moduledep" {

  provisioner "local-exec" {
    command = "echo ${var.module_depends_on}"
  }
}


resource "local_file" "kube_config_home" {
  count             = data.external.default.result["enabled"]
  content           = var.helm-cert-manager-kube_config_file
  filename          = local.kubeconfig-home
}


// ---------------------------------------------------------------------------
// Install cert manager helm chart
// ---------------------------------------------------------------------------
resource "helm_release" "cert-manager" {
  count             = data.external.default.result["enabled"]
  name              = "${var.namespace}-cert-manager"
  repository        = "https://charts.jetstack.io"
  chart             = "cert-manager"
  namespace         = var.namespace
  version           = "v1.2.0"
  timeout           = 120
  verify            = false
  create_namespace  = true

  set {
    name            = "installCRDs"
    value           = true
  }
   
  depends_on        = [
    null_resource.moduledep,
    local_file.kube_config_home,
    null_resource.moduledep

  ]
}


// ---------------------------------------------------------------------------
// Create a cluster issuer
// ---------------------------------------------------------------------------

resource "local_file" "issuer_manifest" {
  count           = data.external.default.result["enabled"]
  filename        = local.issuerManifest

  content         = <<-EOF

apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: "letsencrypt-production"
  namespace: ${var.namespace}
spec:
  acme:
    email: ${data.external.default.result["az_email"]}
    server: "https://acme-v02.api.letsencrypt.org/directory"
    privateKeySecretRef:
      name: "letsencrypt-production"
    solvers:
    - dns01:
        azureDNS:
          clientID: ${join("",azuread_application.service_principal.*.application_id,)}
          clientSecretSecretRef:
            name: az-certmgr-secret
            key: password
          subscriptionID: ${var.az_subscription_id}
          tenantID: ${var.az_tenant_id}
          resourceGroupName: ${var.base_name}dnsRg1
          hostedZoneName: ${local.platform_domain}
          # Azure Cloud Environment, default to AzurePublicCloud
          environment: AzurePublicCloud
EOF
  depends_on      = [
    helm_release.cert-manager,
    kubernetes_secret.spdetails,
    azurerm_role_assignment.service_principal,
    null_resource.moduledep
  ]
}


// ---------------------------------------------------------------------------
// Apply the ClusterIssuer yaml with kubectl
// ---------------------------------------------------------------------------
resource "null_resource" "apply_issuer_manifest" {
  count           = data.external.default.result["enabled"]

  provisioner "local-exec" {
    command       = "kubectl apply -f ${local.issuerManifest} --kubeconfig=${local.kubeconfig} --validate=false"
  }
  depends_on      = [
    helm_release.cert-manager,
    kubernetes_secret.spdetails,
    azurerm_role_assignment.service_principal,
    local_file.issuer_manifest,
    null_resource.moduledep
  ]
}


// ---------------------------------------------------------------------------
// Create the wildcard crt yaml file
// ---------------------------------------------------------------------------
resource "local_file" "SSLcrt" {
  count           = data.external.default.result["enabled"]
  filename        = local.wildcardSSLcrt

  content         = <<-EOF
apiVersion: cert-manager.io/v1alpha2
kind: Certificate
metadata:
  name: wildcard-${var.base_name}-gdpdentsu-net
  namespace: ${var.cert_namespace}
spec:
  secretName: wildcard-devops-tls
  issuerRef:
    name: letsencrypt-production
    kind: ClusterIssuer
  commonName: '*.${local.platform_domain}'
  dnsNames:
  - '*.${local.platform_domain}'
  - '${local.platform_domain}'
  acme:
    config:
    - dns01:
        provider: azuredns
      domains:
      - '*.${local.platform_domain}'
      - '${local.platform_domain}'
EOF

}


// ---------------------------------------------------------------------------
// Apply the crt yaml with kubectl
// ---------------------------------------------------------------------------
resource "null_resource" "wildcardSSLcrt" {
  count           = data.external.default.result["enabled"]

  provisioner "local-exec" {
    command       = "kubectl apply -f ${local.wildcardSSLcrt} --kubeconfig=${local.kubeconfig} --validate=false"
  }

  depends_on      = [
    local_file.SSLcrt,
    local_file.kube_config,
    helm_release.cert-manager,
    null_resource.apply_issuer_manifest,

  ]
}


// ---------------------------------------------------------------------------
// Create random password for service principle
// ---------------------------------------------------------------------------
resource "random_string" "password" {
  count           = data.external.default.result["enabled"] 
  length          = 32
}


// ---------------------------------------------------------------------------
// Sort out enabled - need to splat
// Create the Service principle app name
// ---------------------------------------------------------------------------
resource "azuread_application" "service_principal" {
  count           = data.external.default.result["enabled"]
  name            = "cert-manager-sp"
  homepage        = "https://cert-manager-sp"
}


// ---------------------------------------------------------------------------
// Create the service principle and associate it with the app
// ---------------------------------------------------------------------------
resource "azuread_service_principal" "service_principal" {
  count           = data.external.default.result["enabled"]
  application_id  = join(
    "",azuread_application.service_principal.*.application_id,
  )
}


// ---------------------------------------------------------------------------
// Create the service principle password
// ---------------------------------------------------------------------------
resource "azuread_service_principal_password" "service_principal" {
  count                = data.external.default.result["enabled"]
  service_principal_id = join("", azuread_service_principal.service_principal.*.id)
  value                = random_string.password[count.index].result
  end_date             = "2090-01-01T01:00:00Z"
}



// ---------------------------------------------------------------------------
// Add role to service principle
// ---------------------------------------------------------------------------
resource "azurerm_role_assignment" "service_principal" {
  count                = data.external.default.result["enabled"]
  scope                = "/subscriptions/${var.az_subscription_id}/resourceGroups/${var.base_name}dnsRg1"
  role_definition_name = var.az_sp_role
  principal_id         = join("", azuread_service_principal.service_principal.*.id)
}


// ---------------------------------------------------------------------------
// Create secret so pods can use SP
// ---------------------------------------------------------------------------
resource "kubernetes_secret" "spdetails" {
  count               = data.external.default.result["enabled"]

  metadata {
    name              = "az-certmgr-secret"
    namespace         = var.namespace
  }

  data = {
    appId             = join("",azuread_application.service_principal.*.application_id,)
    displayName       = join("",azuread_service_principal.service_principal.*.display_name,)
    objectId          = join("", azuread_service_principal.service_principal.*.id)
    name              = "cert-manager-sp"
    password          = random_string.password[count.index].result
    tenant            = var.az_tenant_id
  }

  depends_on          = [
    azurerm_role_assignment.service_principal,
    helm_release.cert-manager,
    null_resource.moduledep
  ]
}


// ---------------------------------------------------------------------------
// Write details to vault
// ---------------------------------------------------------------------------
resource "vault_generic_secret" "spdetails" {
  count               = data.external.default.result["enabled"]
  path                = local.vaultCertManager

  data_json           = <<EOT
 {
  "appId": "${join(
  "",
  azuread_application.service_principal.*.application_id,
  )}",
  "displayName": "${join(
  "",
  azuread_service_principal.service_principal.*.display_name,
)}",
  "name": "cert-manager-sp",
  "password": "${random_string.password[count.index].result}",
  "tenant": "${var.az_tenant_id}"
 }
EOT

  depends_on          = [
    azurerm_role_assignment.service_principal,
    null_resource.moduledep
  ]
}

// Create default gateway for cluster
data "template_file" "gateway_template" {
  template = "${file("${path.module}/config/istio-gw.yaml")}"
}

resource "null_resource" "create_gateway" {
  count = data.external.default.result["enabled"]
  triggers = {
    manifest_sha1 = "${sha1("${data.template_file.gateway_template.rendered}")}"
  }
  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig=${local.kubeconfig} -f -<<EOF\n${data.template_file.gateway_template.rendered}\nEOF"
  }
  depends_on = [helm_release.cert-manager, ]
}
