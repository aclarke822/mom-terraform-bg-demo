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
    key            = "mom-terraform-bg-demo-packer"
    region         = "us-east-1"
    dynamodb_table = "ac-tf-rs-locks-production-993058117004"
  }
}
