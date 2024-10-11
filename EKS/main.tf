#vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zone.azs.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    name        = "eks-vpc"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "eks" {
  source = "terraform-aws-modules/els/aws"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.24"

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    node = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_type = ["t2.small"]
    }
  }

  tags = {
    Environment = "dev"
  }

}