locals {
  tags = {
    Environment = var.env
    ProjectName = var.project_name
  }
  name                         = "${var.project_name}-${var.env}"
  vpc_name                     = "${local.name}-vpc"
  vpc_internet_gateway_name    = "${local.name}-gw"
  vpc_public_subnet_name       = "${local.name}-subnet-public"
  vpc_public_route_table_name  = "${local.name}-rt-public"
  vpc_private_subnet_name      = "${local.name}-subnet-private"
  vpc_private_route_table_name = "${local.name}-rt-private"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.tags, {
    Name = local.vpc_name
  })
}

# public routing
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.tags, {
    Name = local.vpc_internet_gateway_name
  })
  depends_on = [aws_vpc.vpc]
}

resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.subnets_public, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.subnets_public)
  map_public_ip_on_launch = true

  tags = merge(local.tags, {
    Name = "${local.vpc_public_subnet_name}${count.index + 1}"
  })
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.tags, {
    Name = local.vpc_public_route_table_name
  })
}

resource "aws_route" "route_public" {
  route_table_id         = aws_route_table.route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "route_table_association_public" {
  count          = length(var.subnets_public)
  subnet_id      = element(aws_subnet.subnet_public.*.id, count.index)
  route_table_id = aws_route_table.route_table_public.id
}

# Private routing
resource "aws_subnet" "subnet_private" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.subnets_private, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count             = length(var.subnets_private)

  tags = merge(local.tags, {
    Name = "${local.vpc_private_subnet_name}${count.index + 1}"
  })
}

resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.tags, {
    Name = local.vpc_private_route_table_name
  })
}

resource "aws_route_table_association" "route_table_association_private" {
  count          = length(var.subnets_private)
  subnet_id      = element(aws_subnet.subnet_private.*.id, count.index)
  route_table_id = aws_route_table.route_table_private.id
}
