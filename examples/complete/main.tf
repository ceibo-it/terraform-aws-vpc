provider "aws" {
  region = var.region
}

module "vpc" {
  source     = "../../"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  cidr_block = "10.0.0.0/16"
}

module "public_subnets" {
  source              = "git::https://github.com/ceibo-it/terraform-aws-subnets.git?ref=0.0.1"
  namespace           = var.namespace
  stage               = var.stage
  name                = var.name
  availability_zones  = ["us-east-2a", "us-east-2b", "us-east-2c"]
  vpc_id              = module.vpc.vpc_id
  cidr_blocks         = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  type                = "public"
  igw_id              = module.vpc.igw_id
  nat_gateway_enabled = "true"
}

module "private_subnets" {
  source             = "git::https://github.com/ceibo-it/terraform-aws-subnets.git?ref=0.0.1"
  namespace          = var.namespace
  stage              = var.stage
  name               = var.name
  availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
  vpc_id             = module.vpc.vpc_id
  cidr_blocks        = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  type               = "private"

  az_ngw_ids = module.public_subnets.az_ngw_ids
}
