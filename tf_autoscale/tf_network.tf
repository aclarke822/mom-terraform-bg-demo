
resource "aws_vpc" "vpc_blue" {
  cidr_block = var.vpc_cidr_blue
  tags = {
    Name = "vpc-blue"
  }
}

resource "aws_vpc" "vpc_green" {
  cidr_block = var.vpc_cidr_green
  tags = {
    Name = "vpc-green"
  }
}

resource "aws_internet_gateway" "igw_blue" {
  vpc_id = aws_vpc.vpc_blue.id

  tags = {
    Name = "igw-blue"
  }
}

resource "aws_internet_gateway" "igw_green" {
  vpc_id = aws_vpc.vpc_green.id

  tags = {
    Name = "igw-green"
  }
}

resource "aws_route_table" "rt_blue" {
  vpc_id = aws_vpc.vpc_blue.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_blue.id
  }
}

resource "aws_route_table" "rt_green" {
  vpc_id = aws_vpc.vpc_green.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_green.id
  }
}

resource "aws_security_group" "sg_blue" {
  vpc_id      = aws_vpc.vpc_blue.id
  name        = "http-https-ssh-blue"
  description = "Blue HTTP/HTTPS/SSH SG"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_green" {
  vpc_id      = aws_vpc.vpc_green.id
  name        = "http-https-ssh-green"
  description = "Green HTTP/HTTPS/SSH SG"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}