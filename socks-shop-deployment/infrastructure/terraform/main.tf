provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name = "socks-shop-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

data "aws_eks_cluster" "socks-shop-cluster" {
  name = "socks-shop-cluster"
}

data "aws_eks_cluster_auth" "socks-shop-cluster" {
  name = data.aws_eks_cluster.socks-shop-cluster.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.socks-shop-cluster.endpoint
  token                  = data.aws_eks_cluster_auth.socks-shop-cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.socks-shop-cluster.certificate_authority[0].data)
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.0.0"
  cluster_name    = "socks-shop-cluster"
  cluster_version = "1.30"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  worker_groups = [
    {
      instance_type = "t3.medium"
      asg_desired_capacity = 3
    }
  ]
}


