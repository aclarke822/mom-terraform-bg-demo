terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.47.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Provisioner = var.provisioner
      Environment = var.environment
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "ac-tf-rs-production-993058117004"
    key            = "mom-terraform-bg-demo"
    region         = "us-east-1"
    dynamodb_table = "ac-tf-rs-locks-production-993058117004"
  }
}

module "deployment_group_blue" {
  source = "./deployment-group"

  lt_version = (var.production_color == "blue" ? var.production_version : aws_launch_template.bluegreen.latest_version)
  #lt_version    = "$Latest"
  blue_or_green    = "blue"
  certificate_arn  = var.certificate_arn
  hosted_zone_name = var.hosted_zone_name
  provisioner      = var.provisioner
  environment      = var.environment
  vpc_cidr         = aws_vpc.vpc_blue.cidr_block
  vpc_id           = aws_vpc.vpc_blue.id
  lt_id            = aws_launch_template.bluegreen.id
  rt_id            = aws_route_table.rt_blue.id
  sg_id            = aws_security_group.sg_blue.id
}

module "deployment_group_green" {
  source = "./deployment-group"

  lt_version       = (var.production_color == "green" ? var.production_version : aws_launch_template.bluegreen.latest_version)
  blue_or_green    = "green"
  certificate_arn  = var.certificate_arn
  hosted_zone_name = var.hosted_zone_name
  provisioner      = var.provisioner
  environment      = var.environment
  vpc_cidr         = aws_vpc.vpc_green.cidr_block
  vpc_id           = aws_vpc.vpc_green.id
  lt_id            = aws_launch_template.bluegreen.id
  rt_id            = aws_route_table.rt_green.id
  sg_id            = aws_security_group.sg_green.id
}
