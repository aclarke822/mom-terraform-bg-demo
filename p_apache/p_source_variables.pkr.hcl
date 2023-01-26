#####################
# General Variables #
#####################

variable "instance_type" {
  description = "instance type for packer build"
  default     = "t3.micro"
}

#####################
# AWS VPC Variables #
#####################

variable "vpc_id" {
  description = "vpc ID for instance creation"
  default     = "vpc-001d6a793d90c4075"
}

variable "subnet_id" {
  description = "subnet ID for instance creation"
  default     = "subnet-0caba365dae84615b"
}

variable "communicator" {
  description = "communication method used for instance"
  default     = "ssh"
}

variable "ssh_username" {
  description = "ssh username for packer to use for provisioning"
  default     = "ec2-user"
}

variable "ssh_interface" {
  description = "ssh interface for packer to use for provisioning"
  default     = "session_manager"
}

variable "iam_instance_profile" {
  description = "IAM instace profile to attach to AMI instance to allow connectivity via session manager"
  default     = "mom-packer"
}