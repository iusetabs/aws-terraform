provider "aws" {
  profile = var.aws_profile
  region  = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
}

