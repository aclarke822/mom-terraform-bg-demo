variable "environment" {
  type = string
}

variable "provisioner" {
  type = string
}


variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "lt_version" {
  type    = string
  default = "$Latest"
}

variable "lt_id" {
  type    = string
  default = "$Latest"
}

variable "rt_id" {
  type = string
}

variable "sg_id" {
  type = string
}

variable "blue_or_green" {
  type    = string
  default = "blue"
}

variable "hosted_zone_name" {
  type    = string
}

variable "certificate_arn" {
  type = string
}