provider "aws" {
  profile = var.aws_profile
  region  = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
}

module "eks" {
  source = "./modules/eks"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets

  // Module variables
  ecr_prefix = var.ecr_prefix
  node_group_name = var.node_group_name
  cluster_version = var.cluster_version
  instance_types = var.instance_types
  cluster_name = var.cluster_name
  ami_type = var.ami_type
  ecr_names = var.ecr_names
  instance_https_port = var.instance_https_port
  instance_http_port = var.instance_http_port
}

module "load-balancer-controller" {
  source = "./modules/load-balancer-controller"
  cluster_oidc_issuer = module.eks.cluster_oidc_issuer
  cluster_endpoint = module.eks.cluster_endpoint
}