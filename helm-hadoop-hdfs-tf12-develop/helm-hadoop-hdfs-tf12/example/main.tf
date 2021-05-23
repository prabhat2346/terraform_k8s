module "helm-hadoop-hdfs-tf12" {
  source                   = "./modules/helm-hadoop-hdfs-tf12"
  namespace                = terraform.workspace
  azure_subscription_alias = var.subscription
  module_name              = "helm-hadoop-hdfs-tf12"
  module_depends_on        = module.helm-ranger-tf12.complete
  base_target              = var.base_target
}
