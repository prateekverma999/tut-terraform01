locals {
  azs = data.aws_availability_zones.available.names
}


resource "random_id" "random" {
    byte_length = 2
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "pro_vpc"{
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "pro_vpc-${random_id.random.dec}"
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_internet_gateway" "pro_igw"{
    vpc_id = aws_vpc.pro_vpc.id

    tags = {
        Name = "pro_igw-${random_id.random.dec}"
    }
}

resource "aws_route_table" "pro_public_rt" {
    vpc_id = aws_vpc.pro_vpc.id

    tags = {
        Name = "pro_public"
    }
}

resource "aws_default_route_table" "pro_private_rt" {
    default_route_table_id = aws_vpc.pro_vpc.default_route_table_id

    tags = {
        Name = "pro_private"
    }
}

resource "aws_route" "pro_default_route" {
    route_table_id = aws_route_table.pro_public_rt.id
    destination_cidr_block = var.dest_cidr
    gateway_id = aws_internet_gateway.pro_igw.id
}

resource "aws_subnet" "pro_public_subnet" {
    count = length(local.azs)
    vpc_id = aws_vpc.pro_vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr, 8, length(local.azs))
    map_public_ip_on_launch = true
    availability_zone = local.azs[count.index]

    tags = {
        Name = "pro_public_${random_id.random.dec}-${count.index + 1}"
    }
}

resource "aws_subnet" "pro_private_subnet" {
    count = length(local.azs)
    vpc_id = aws_vpc.pro_vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr, 8, length(local.azs) + 1)
    availability_zone = local.azs[count.index]

    tags = {
        Name = "pro_private_${random_id.random.dec}-${count.index + 1}"
    }
}