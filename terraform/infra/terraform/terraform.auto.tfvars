# Global
region = "ap-south-1"

# Networking
route53-zone                   = "squareops.xyz"
vpc_cidr                       = "10.0.0.0/16"
public_subnets                 = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets                = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
create_high_security_grade_vpc = "true"

# EKS
MAIN             = "prod2"
EKS_CLUSTER_NAME = "staging"
instance_type    = "t3a.medium"
desired_capacity = 2

# RDS
environment       = "prod"
db_name           = "sampledb"
db_version        = "5.6.40"
instance_count    = 2
rds_instance_name = "stagingdb"
db_instance_class = "db.t2.micro"
db_username       = "staginguser"
db_password       = "mystrongpass12345"
db_storage        = 5

# Vault
enable_consul_and_vault = false

# Rancher
enable_rancher       = true
rancher-route53-host = "rancher20"
# vault_url = "http://13.229.153.25:8200/"
rancher_cert= "secrets/rancher-cert"
rancher_key = "secrets/rancher-key"

# Testapp
testapp-ecr="testapp"
testapp-route53-hosts=["testapp-host1","testapp-host2","testapp-host3","testapp-host4"]
testapp-route53-hostnames=["testapp-host1.squareops.xyz", "testapp-host2.squareops.xyz", "testapp-host3.squareops.xyz", "testapp-host4.squareops.xyz"]
testapp-crt-path=["secrets/testapp-host1-cert", "secrets/testapp-host2-cert","secrets/testapp-host3-cert", "secrets/testapp-host4-cert"]
testapp-key-path=["secrets/testapp-host1-key", "secrets/testapp-host2-key","secrets/testapp-host3-key", "secrets/testapp-host4-key"]

