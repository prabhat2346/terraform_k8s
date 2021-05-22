// The azure subscription id
variable "azure_subscription_id" {
  default     = ""
  description = "The azure subscription id"
}

// The dns resource group from the base
variable "dnsrg" {
  default     = ""
  description = "The dns resource group"
}

// A map of the registries that you need access to
variable "registries" {
  type        = map(string)
  description = "A map of the registries that you need access to"
  default = {
    registry = "id"
  }
}

// A list of registries that you need access to
variable "registry_perms" {
  type        = list(string)
  description = "A list of registries that you need access to"
  default     = []
}

// The tags to associate
variable "azurerm-aks_tags" {
  type        = map(string)
  description = "The tags to associate"
  default     = {}
}

// The anchore user
variable "anchore_user" {
  type        = string
  description = "The anchore use to use"
  default     = "admin"
}

// The Anchore Url to use
variable "anchore_url" {
  type        = string
  description = "The Anchore Url to use"
  default     = "https://anchore.saas.gcp.gdp-devops.gdpdentsu.net/v1"
}

// The Anchore Url to use
variable "anchore_password" {
  type        = string
  description = "The anchore password to use"
  default     = "admin"
}

// Whether to verify the anchore ssl cert
variable "anchore_sslverify" {
  type        = string
  description = "Whether to verify the anchore ssl cert"
  default     = "false"
}

// Default ad appid 
variable "client_app_id" {
  type        = string
  description = "Default ad appid"
  default     = "a00a0a00-0a00-0000-a000-0000aaaaaa00"
}

// Set to dummy server app id
variable "server_app_id" {
  type        = string
  description = "Default ad appid"
  default     = "a00a0a00-0a00-0000-a000-0000aaaaaa00"
}

// Set to dummy server app id
variable "server_app_secret" {
  type        = string
  description = "Default ad appid"
  default     = "a00a0a00-0a00-0000-a000-0000aaaaaa00"
}

// The default deployment region - these need to get mapped to actual regions
variable "mef_deployment_region" {
  default = "emea"
}

// The mef cluster network 
variable "mef_cluster_network" {
  default = "nonprod"
}

// The mef cluster type
variable "mef_cluster_type" {
  default = "data"
}

variable "envwhitelistarray" {
  default     = []
  description = "envwhitelist is a computed list of ip addresses to whitelist"
}
