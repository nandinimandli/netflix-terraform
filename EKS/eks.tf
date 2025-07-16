module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "12.2.0"

  cluster_name                   = local.name
  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  worker_groups_launch_template = [
    {
      name                    = "amc-cluster-wg"
      instance_type           = "t3.large"
      asg_desired_capacity    = 1
      asg_min_size            = 1
      asg_max_size            = 2
      spot_price              = "auto"
      override_instance_types = ["t3.large"]
      additional_tags = {
        ExtraTag = "helloworld"
      }
    }
  ]

  tags = local.tags
}
