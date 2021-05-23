// The namespace to deploy into
variable "namespace" {
  default     = ""
  description = "The namespace to deploy into"
}

// Default module dependency declaration
variable "module_depends_on" {
  default     = ""
  description = "Default module dependency declaration"
}

// Use azure client id
variable "az_client_id" {
  default     = ""
  description = "Use azure client id"
}

// Use azure client secret
variable "az_client_secret" {
  default     = ""
  description = "Use azure client secret"
}

// Use azure subscription id
variable "az_subscription_id" {
  default     = ""
  description = "Use azure subscription id"
}

// Use azure subscription id
variable "subscription" {
  default     = ""
  description = "Use azure subscription id"
}


// Use azure tenant id
variable "az_tenant_id" {
  default     = ""
  description = " Use azure tenant id"
}

// Use azure hosted zone id
variable "az_hosted_zone" {
  default     = ""
  description = "Use azure hosted zone id"
}

// SP Role
variable "az_sp_role" {
  default     = "Contributor"
  description = "Sets SP role"
}

// Base target of the config
variable "base_target" {
  default     = ""
  description = ""
}

// The module name of the module
variable "module_name" {
  description = "The Module name of the module"
  default     = "helm-cert-manager-target-tf12"
}

variable "base_name" {
  default     = ""
  description = ""
}

// Base target of the config
variable "deployment_type" {
  default     = "target"
  description = ""
}

// The azure subscription alias that you would like to deploy to
variable "azure_subscription_alias" {
  default     = ""
  description = "The azure subscription alias that you would like to deploy to"
}

variable "helm-cert-manager-kube_config_file" {
  description = "kube config file"
  default     = ""
}

variable "helm-cert-manager-kube_server" {
  description = "kube server"
  default     = ""
}

variable "helm-cert-manager-client-key-data" {
  description = "kube client key"
  default     = ""
}

variable "helm-cert-manager-client-certificate-data" {
  description = "kube cert"
  default     = ""
}

variable "helm-cert-manager-certificate-authority-data" {
  description = "kube ca"
  default     = ""
}

variable "cert_namespace" {
  description = "The namespace where the wildcard-tls-cert TLS secret will be created"
  default     = "istio-system"
}

variable "dnsid" {
  default = ""
}
