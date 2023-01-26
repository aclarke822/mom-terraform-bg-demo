variable "env" {
  description = "unique environment/stage name"
  default     = "sandbox"
}

variable "service" {
  description = "Service Name"
  default     = "apache"
}

variable "region" {
  description = "AWS region name"
  default     = "us-east-1"
}

locals {
  identifier = "mom-demo-${var.service}"
  timestamp  = regex_replace(timestamp(), "[- TZ:]", "")

  ami_name = "${local.identifier}-${local.timestamp}"
}