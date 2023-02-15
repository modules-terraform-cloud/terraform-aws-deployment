# Create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "VPC Test"
  }
}

# Create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "IGW"
  }
}

# Allocate elastic ip. this eip will be used for the nat-gateway in the public subnet
resource "aws_eip" "eip_nat_gateway" {
  vpc    = true

  tags   = {
    Name = "EIP allocation"
  }
}

# Create nat gateway in public subnet
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_nat_gateway.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags   = {
    Name = "NAT GW"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  # on the internet gateway for the vpc.
  depends_on = [aws_internet_gateway.internet_gateway]
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available" {
  state = "available"
}


# Create public subnet
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Public-subnet-${count.index}"
  }
}

# create private subnet
resource "aws_subnet" "private_subnet" {
  count                    = length(var.private_subnet_cidrs)
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_subnet_cidrs[count.index]
  availability_zone        = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Private-subnet-${count.index}"
  }
}

# Create private data subnets
resource "aws_subnet" "private_data_subnet" {
  count                    = length(var.private_data_subnet_cidrs)
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_data_subnet_cidrs[count.index]
  availability_zone        = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Private-db-subnet-${count.index}"
  }
}


# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = var.anyware_cidr_range
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "Public-route-table"
  }
}

# associate public subnet to "public route table"
resource "aws_route_table_association" "route_public_subnet_association" {
  count               = length(var.public_subnet_cidrs)
  subnet_id           = aws_subnet.public_subnet[count.index].id
  route_table_id      = aws_route_table.public_route_table.id
}


# create private route table and add route through nat gateway
resource "aws_route_table" "private_route_table" {
  vpc_id            = aws_vpc.vpc.id

  route {
    cidr_block      = var.anyware_cidr_range
    nat_gateway_id  = aws_nat_gateway.nat_gateway.id
  }

  tags   = {
    Name = "Private-route-table"
  }
}

# associate private subnet with private route table
resource "aws_route_table_association" "route_private_subnet_association" {
  count             = length(var.private_subnet_cidrs)
  subnet_id         = aws_subnet.private_subnet[count.index].id
  route_table_id    = aws_route_table.private_route_table.id
}

# create private data route table and add route through nat gateway
resource "aws_route_table" "private_data_route_table" {
  vpc_id            = aws_vpc.vpc.id

  route {
    cidr_block      = var.anyware_cidr_range
    nat_gateway_id  = aws_nat_gateway.nat_gateway.id
  }

  tags   = {
    Name = "Private-data-route-table"
  }
}

# associate private data subnet with private route table
resource "aws_route_table_association" "route_private_data_subnet_association" {
  count             = length(var.private_data_subnet_cidrs)
  subnet_id         = aws_subnet.private_data_subnet[count.index].id
  route_table_id    = aws_route_table.private_data_route_table.id
}

