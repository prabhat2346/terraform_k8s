// Default dependency declaration
variable "module_depends_on" {
  default     = ""
  description = "Default dependency declaration"
}

// SSH key
variable "sshRSAPublicKey" {
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWGW1STMK4p6vDXywL3yUImC1WYrbXPRqRvKzx+WAoM2bEsj4QkCjhm29ef142TVnGT7mw1vzS/8H1MB1jc35QpK9RNcf5zgkwaf9PtmJ3xO7uxZ4pqmhgHx2W24rwrSRYKljnmjwwQkFIPbaoMUx0SHkOuXYo7EnBtOrb8yJvmARso/kFSx7GWFVvL32FxuHycjTYkTRbZ0ZYEQP2s+/3OPsa5xZHmzoFiN40h+uhQUJabhxcjY/umcFuPBhYFvhBWMR0a/YMnX+YzLMsY5hR0BZVDn/aSDF1mJoToRgcJTZlA8PPRpBoQMUI/mDwskOWfJS8K+z3zpKUJc0BJp2j changethis@dbag.com"
  description = "ssh-key needed to access kubernetes"
}

// Used to trigger resources
variable "depends_id" {
  description = "Used to trigger resources"
  default     = ""
}

// Deployment type one of target, base, team, project
variable "deployment_type" {
  description = "The deployment type, 1 of target, team, project, base"
  default     = "target"
}

// The Module name
variable "module_name" {
  description = "The Module name of the module"
  default     = "azurerm-aks-tf12"
}

// Number of years for a valid service principle
variable "years" {
  description = "The number of years this service principle is valid for"
  default     = 10
}

// The End date you would like the service principle to expire
variable "end_date" {
  default     = ""
  description = "The End Date which the Password is valid until, formatted as a RFC3339 date string (e.g. `2020-01-01T01:02:03Z`). Overrides `years`."
}

// The password for the service principle
variable "password" {
  default     = ""
  description = "The Password for this Service Principal."
}

// The role required for the SP
variable "role" {
  default     = "Contributor"
  description = "The name of a built-in Role."
}

// The azure subscription id
variable "azure_subscription_id" {
  default     = ""
  description = "The azure subscription id"
}

// The dns resource group associated with the dns zone
variable "dnsrg" {
  default     = ""
  description = "The dns resource group"
}

// A map of registries you would like to gain access to
variable "registries" {
  type        = map(string)
  description = "A map of registries you would like to gain access to"
  default = {
    registry = "id"
  }
}

// A list of registries you would like to have access to
variable "registry_perms" {
  type        = list(string)
  description = "A list of registries you would like to have access to"
  default     = []
}

// The azure subscription alias that you would like to deploy to
variable "azure_subscription_alias" {
  default     = ""
  description = "The azure subscription alias that you would like to deploy to"
}

// The OS variant of the terraform client
variable "os_type" {
  type        = string
  description = "The operating system that your terraform client is running on"
  default     = "linux"
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

// The tags to associates
variable "azurerm-aks_tags" {
  type        = map(string)
  description = "The tags to associate"
  default     = {}
}

// Azure cloud environment
variable "azure_env" {
  description = "Azure cloud environment, e.g. China"
  default     = "public"
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

// The Azure client id for azurerm provider
variable "azure_client_id" {
  type        = string
  description = "The Azure client id for azurerm provider"
  default     = ""
}

// The Azure client secret for azurerm provider
variable "azure_client_secret" {
  type        = string
  description = "The Azure client secret for azurerm provider"
  default     = ""
}

// The Azure tenant id for azurerm provider
variable "azure_tenant_id" {
  type        = string
  description = "The Azure tenant id for azurerm provider"
  default     = ""
}

// The default deployment region - these need to get mapped to actual regions
variable "mef_deployment_region" {
  default = "emea"
}

// The default deployment region - these need to get mapped to actual regions
variable "mef_functional_env" {
  default = "nonprod-1"
}

// The mef cluster network 
variable "mef_cluster_network" {
  default = "nonprod-1-int"
}

// The mef cluster type
variable "mef_cluster_type" {
  default = "data"
}

variable "envwhitelistarray" {
  default     = []
  description = "envwhitelist is a computed list of ip addresses to whitelist"
}

// Add config for Additional Node Pools
variable "node_pools" {
  description = "List of additional node pool objects to be created"
  default     = []
}

variable "cprovider" {
  default = "azure"
}