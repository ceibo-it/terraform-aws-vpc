# terraform-aws-vpc 

Terraform module to provision a VPC with Internet Gateway.




## Examples

```hcl
module "vpc" {
  source     = "git::https://github.com/ceibo-it/terraform-aws-vpc.git?ref=0.0.1"
  namespace  = "eg"
  stage      = "test"
  name       = "app"
  cidr_block = "10.0.0.0/16"
}
```

Full example with [`terraform-aws-subnets`](https://github.com/ceibo-it/terraform-aws-subnets.git):

```hcl
module "vpc" {
  source     = "git::https://github.com/ceibo-it/terraform-aws-vpc.git?ref=0.0.1"
  namespace  = "eg"
  stage      = "test"
  name       = "app"
  cidr_block = "10.0.0.0/16"
}

module "public_subnets" {
  source              = "git::https://github.com/ceibo-it/terraform-aws-subnets.git?ref=0.0.1"
  namespace           = var.namespace
  stage               = var.stage
  name                = var.name
  availability_zones  = ["us-east-2a", "us-east-2b", "us-east-2c"]
  vpc_id              = module.vpc.vpc_id
  cidr_blocks          = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
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
  cidr_blocks         = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  type               = "private"

  az_ngw_ids = module.public_subnets.az_ngw_ids
}
```



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes | Additional attributes (e.g. `1`) | list(string) | `<list>` | no |
| cidr_block | CIDR for the VPC | string | - | yes |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| enable_classiclink | A boolean flag to enable/disable ClassicLink for the VPC | bool | `false` | no |
| enable_classiclink_dns_support | A boolean flag to enable/disable ClassicLink DNS Support for the VPC | bool | `false` | no |
| enable_default_security_group_with_custom_rules | A boolean flag to enable/disable custom and restricive inbound/outbound rules for the default VPC's SG | bool | `true` | no |
| enable_dns_hostnames | A boolean flag to enable/disable DNS hostnames in the VPC | bool | `true` | no |
| enable_dns_support | A boolean flag to enable/disable DNS support in the VPC | bool | `true` | no |
| instance_tenancy | A tenancy option for instances launched into the VPC | string | `default` | no |
| name | Name  (e.g. `app` or `cluster`) | string | - | yes |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | string | `` | no |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | `` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | map(string) | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| igw_id | The ID of the Internet Gateway |
| ipv6_cidr_block | The IPv6 CIDR block |
| vpc_cidr_block | The CIDR block of the VPC |
| vpc_default_network_acl_id | The ID of the network ACL created by default on VPC creation |
| vpc_default_route_table_id | The ID of the route table created by default on VPC creation |
| vpc_default_security_group_id | The ID of the security group created by default on VPC creation |
| vpc_id | The ID of the VPC |
| vpc_ipv6_association_id | The association ID for the IPv6 CIDR block |
| vpc_main_route_table_id | The ID of the main route table associated with this VPC |




## Copyright

Copyright © 2017-2020 [Cloud Posse, LLC](https://cpco.io/copyright)



## License 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.



## Trademarks

All other trademarks referenced herein are the property of their respective owners.



## NOTICE

terraform-aws-vpc
Copyright 2020 Ceibo


This product includes software developed by
Cloud Posse, LLC (c) (https://cloudposse.com/)
Licensed under Apache License, Version 2.0
Copyright © 2017-2019 Cloud Posse, LLC
