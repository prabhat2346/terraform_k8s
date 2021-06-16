// Namespace to install the service to
variable "namespace" {
  description = "Namespace to install the service to"
  default     = ""
}

// Default module dependency declaration
variable "module_depends_on" {
  default     = ""
  description = "Default module dependency declaration"
}

// Set deployment type target/team/base/project
variable "deployment_type" {
  description = "The deployment type"
  default     = "team"
}

// Set module name
variable "module_name" {
  description = "The Module name"
  default     = ""
}

// The azure subscription alias that you would like to deploy to
variable "azure_subscription_alias" {
  default     = ""
  description = "The azure subscription alias that you would like to deploy to"
}

variable "base_target" {
  default     = ""
  description = ""
}

variable "group_id" {
  description = "List of ad group object IDs that require dev level access"
  default     = []
}

// The primary target resource group
variable "aksRG" {
  description = "The primary target resource group"
  default     = ""
}

// The azure subscription id 
variable "az_subscription_id" {
  description = "The azure subscription id"
  default     = ""
}
