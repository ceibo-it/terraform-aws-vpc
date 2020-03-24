module "label" {
  source     = "git::https://github.com/ceibo-it/terraform-null-label.git?ref=tags/0.0.1"
  namespace  = var.namespace
  name       = var.name
  stage      = var.stage
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

resource "aws_vpc" "default" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = true
  tags                             = module.label.tags
}

# If `aws_default_security_group` is not defined, it would be created implicitly with access `0.0.0.0/0`
resource "aws_default_security_group" "default" {
  count  = var.enable_default_security_group_with_custom_rules ? 1 : 0
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "Default Security Group"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags   = module.label.tags
}