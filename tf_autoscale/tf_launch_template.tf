locals {
  color           = (var.production_color == "blue" ? "green" : "blue")
  security_groups = (var.production_color == "blue" ? [aws_security_group.sg_green.id] : [aws_security_group.sg_blue.id])
}

data "template_file" "user_data" {
  template = file("./shell/user_data.sh")
  vars = {
    color = local.color
    amiId = var.ami_image_id
  }
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "key-bluegreen-deployer"
  public_key = tls_private_key.key.public_key_openssh
}

resource "aws_launch_template" "bluegreen" {
  name                                 = "lt-bluegreen"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"

  update_default_version  = true
  disable_api_stop        = false
  disable_api_termination = false
  ebs_optimized           = false

  image_id  = var.ami_image_id
  key_name  = aws_key_pair.deployer.key_name
  user_data = base64encode(data.template_file.user_data.rendered)


  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = local.security_groups
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = local.color
    }
  }
}