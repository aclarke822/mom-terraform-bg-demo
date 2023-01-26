
data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_shuffle" "az" {
  input        = data.aws_availability_zones.available.names
  result_count = 2
}

resource "aws_subnet" "primary" {
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 1)
  availability_zone = random_shuffle.az.result[0]

  tags = {
    Name = "subnet-${var.blue_or_green}1"
  }
}

resource "aws_subnet" "secondary" {
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 2)
  availability_zone = random_shuffle.az.result[1]

  tags = {
    Name = "subnet-${var.blue_or_green}2"
  }
}

resource "aws_route_table_association" "rta_b1" {
  subnet_id      = aws_subnet.primary.id
  route_table_id = var.rt_id
}

resource "aws_route_table_association" "rta_b2" {
  subnet_id      = aws_subnet.secondary.id
  route_table_id = var.rt_id
}