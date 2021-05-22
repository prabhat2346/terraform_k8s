##NETWORKING
variable "route53-zone" {}
variable "vpc_cidr" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "create_high_security_grade_vpc" {}

##EKS
variable "region" {}
variable "MAIN" {}
variable "EKS_CLUSTER_NAME" {}
variable "eks_version" {
  default = "1.17"
}
variable "desired_capacity" {}
variable "instance_type" {}

#RDS-VARIABLES
variable "environment" {}
variable "db_name" {}
variable "db_version" {}
variable "instance_count" {}
variable "rds_instance_name" {}
variable "db_instance_class" {}
variable "db_username" {}
variable "db_password" {}
variable "db_storage" {}

##RANCHER
variable "enable_rancher" {
  type    = bool
  default = true
}
# variable "vault_url" {}
variable "rancher_key" {}
variable "rancher_cert" {}
variable "rancher-route53-host" {}

##VAULT
variable "enable_consul_and_vault" {
  type    = bool
  default = true
}