#RDS
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "${var.rds_instance_name}"

  engine            = "mysql"
  engine_version    = "${var.db_version}"
  instance_class    = "${var.db_instance_class}"
  allocated_storage = "${var.db_storage}"

  name     = "${var.db_name}"
  username = "${var.db_username}"
  password = "${var.db_password}"
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [module.rds_sg.this_security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = "${var.MAIN}-MyRDSMonitoringRole1"
  create_monitoring_role = true

  tags = {
    Name        = "Mysql-rds"
    "Wordpress" = "Application"
    Environment = "${var.environment}"
  }
  # DB subnet group
  subnet_ids = [module.vpc_main.public_subnets[0], module.vpc_main.public_subnets[1]]
  # DB parameter group
  family = "mysql5.6"
  # DB option group
  major_engine_version = "5.6"
  # Snapshot name upon DB deletion
  final_snapshot_identifier = "Wordpress-snapshot"
  # Database Deletion Protection
  deletion_protection = false
}

module "rds_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "Db-security-group"
  description = "Security group for database"
  vpc_id      = module.vpc_main.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "Db-inbound-port"
      cidr_blocks = "10.0.0.0/16"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "Db-outbound-port"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
