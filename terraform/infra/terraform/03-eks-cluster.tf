data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}


resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.vpc_main.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

resource "aws_security_group" "worker_group_mgmt_two" {
  name_prefix = "worker_group_mgmt_two"
  vpc_id      = module.vpc_main.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
    ]
  }
}

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc_main.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "${var.MAIN}-${var.EKS_CLUSTER_NAME}"
  subnets         = [module.vpc_main.private_subnets[0], module.vpc_main.private_subnets[1]]
  cluster_version = "${var.eks_version}"

  tags = {
    Environment = "dev"
  }

  vpc_id = module.vpc_main.vpc_id

  node_groups = {
    eks_nodes = {
      desired_capacity = "${var.desired_capacity}"
      max_capacity     = 10
      min_capaicty     = 1
      instance_type    = "${var.instance_type}"
    }
  }
  manage_aws_auth = false
}

resource "aws_iam_role_policy_attachment" "prod-node-AutoscalerPolicy" {
  policy_arn = aws_iam_policy.prod-node-autoscaler-policy.arn
  role       = module.eks.worker_iam_role_name
}
resource "aws_iam_policy" "prod-node-autoscaler-policy" {
  name        = "${var.MAIN}-prod-node-autoscaler-policy"
  path        = "/"
  description = "prod-node-autoscaler-policy"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
