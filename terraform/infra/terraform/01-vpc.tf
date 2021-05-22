module "vpc_main" {
  source                               = "terraform-aws-modules/vpc/aws"
  version                              = "~>2.39.0"
  create_vpc                           = "${var.create_high_security_grade_vpc}"
  name                                 = "${var.MAIN}-VPC"
  cidr                                 = "${var.vpc_cidr}" #CIDR BLOCK FOR VPC
  azs                                  = data.aws_availability_zones.available.names
  public_subnets                       = "${var.public_subnets}" #CIDR FOR SUBNETS
  private_subnets                      = "${var.private_subnets}"
  enable_nat_gateway                   = "true"
  single_nat_gateway                   = "true"
  one_nat_gateway_per_az               = "false"
  enable_dns_hostnames                 = "true"
  enable_vpn_gateway                   = "false"
  manage_default_network_acl           = "true"
  enable_flow_log                      = "true"
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_traffic_type                = "ALL"
  create_flow_log_cloudwatch_log_group = true
  #flow_log_max_aggregation_interval    = 60
  flow_log_destination_type = "cloud-watch-logs"
  #TAGS TO BE ASSOCIATED WITH EACH RESOURCE
  tags = {
    "${var.MAIN}" = "Terraform-vpc-resources"
    "Environment" = "${var.environment}"
  }
  public_subnet_tags = map(
    "Name", "${var.MAIN}-squareops-eks-${var.EKS_CLUSTER_NAME}",
    "kubernetes.io/cluster/${var.MAIN}-${var.EKS_CLUSTER_NAME}", "shared",
  )
  private_subnet_tags = map(
    "Name", "${var.MAIN}-squareops-eks-${var.EKS_CLUSTER_NAME}",
    "kubernetes.io/cluster/${var.MAIN}-${var.EKS_CLUSTER_NAME}", "shared",
  )
  #TAGGING FOR DEFAULT NACL
  default_network_acl_name = "${var.MAIN}-NACL"
  default_network_acl_tags = {
    "${var.MAIN}" = "Terraform-wordpress-acl"
    "Environment" = "${var.environment}"
  }
}