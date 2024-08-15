# Define the AWS provider and region for the resources
provider "aws" {
  region = "us-east-1"  # AWS region where resources will be created
}

# Define a VPC module to create a Virtual Private Cloud
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"  # Source of the VPC module from the Terraform AWS Modules repository
  version = "3.0.0"  # Version of the VPC module to use

  name = "socks-shop-vpc"  # Name of the VPC
  cidr = "10.0.0.0/16"  # CIDR block for the VPC

  # Availability Zones for the VPC
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  # Private subnets within the VPC
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  # Public subnets within the VPC
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  # Enable NAT gateway for outbound internet access from private subnets
  enable_nat_gateway = true
  # Use a single NAT gateway for the entire VPC
  single_nat_gateway = true
}

# Data source to retrieve information about the existing EKS cluster
data "aws_eks_cluster" "socks-shop-cluster" {
  name = "socks-shop-cluster"  # Name of the EKS cluster to retrieve
}

# Data source to retrieve the authentication details for the EKS cluster
data "aws_eks_cluster_auth" "socks-shop-cluster" {
  name = data.aws_eks_cluster.socks-shop-cluster.name  # Name of the EKS cluster for authentication
}

# Define the Kubernetes provider using the EKS cluster details
provider "kubernetes" {
  host                   = data.aws_eks_cluster.socks-shop-cluster.endpoint  # Endpoint for the EKS cluster
  token                  = data.aws_eks_cluster_auth.socks-shop-cluster.token  # Authentication token for the EKS cluster
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.socks-shop-cluster.certificate_authority[0].data)  # Base64-decoded CA certificate for the EKS cluster
}

# Define an EKS module to create and manage an Amazon EKS cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"  # Source of the EKS module from the Terraform AWS Modules repository
  version         = "17.0.0"  # Version of the EKS module to use
  cluster_name    = "socks-shop-cluster"  # Name of the EKS cluster
  cluster_version = "1.30"  # Version of the EKS cluster
  subnets         = module.vpc.private_subnets  # Private subnets from the VPC module for the EKS cluster
  vpc_id          = module.vpc.vpc_id  # VPC ID from the VPC module

  # Configuration for worker nodes
  worker_groups = [
    {
      instance_type = "t3.medium"  # EC2 instance type for the worker nodes
      asg_desired_capacity = 3  # Desired number of worker nodes in the Auto Scaling Group
    }
  ]
}
