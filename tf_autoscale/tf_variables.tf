variable "environment" {
  type = string
}

variable "provisioner" {
  type = string
}

variable "vpc_cidr_blue" {
  type    = string
  default = "10.1.0.0/16"
}

variable "vpc_cidr_green" {
  type    = string
  default = "10.2.0.0/16"
}

variable "production_color" {
  type    = string
  default = "blue"
}

variable "production_version" {
  type    = string
  default = "0"
}

variable "ami_image_id" {
  type = string
}

variable "hosted_zone_name" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "instance_count" {
  type = number
}