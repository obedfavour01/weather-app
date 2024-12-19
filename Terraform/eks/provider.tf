locals {
  region          = "us-east-2"
  name            = "weatherapp-cluster"
  vpc_cidr        = "10.12.0.0/16"
  azs             = ["us-east-2a", "us-east-2b"]
  public_subnets  = ["10.12.1.0/24", "10.12.2.0/24"]
  private_subnets = ["10.12.3.0/24", "10.12.4.0/24"]
  intra_subnets   = ["10.12.5.0/24", "10.12.6.0/24"]
  tags = {
    Example = local.name
  }
}

provider "aws" {
  region = "us-east-2"
}
