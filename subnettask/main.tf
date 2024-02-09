resource "random_id" "random" {
    byte_length = 2
}

resource "aws_vpc" "pro_vpc"{
    cidr_block = var.vpc_cidr
    enable_dns_hostname = true
    enable_dns_support = true

    tag = {
        Name = "pro_vpc-${random_id.random.dec}"
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_internet_gateway" "pro_igw"{
    vpc_id = aws_vpc.pro_vpc.id

    tag = {
        Name = "pro_igw-${random_id.random.dec}"
    }
}

resource "aws_route_table" "pro_public_rt" {
    vpc_id = aws_vpc.pro_vpc.id

    tag = {
        Name = "pro_public"
    }
}

resource "aws_default_route_table" "pro_private_rt" {
    default_route_table_id = aws_vpc.pro_vpc.default_route_table_id

    tag = {
        Name = "pro_private"
    }
}

resource "aws_route" "pro_default_route" {
    route_table_id = aws_route_table.pro_public_rt.id
    destination_cidr_block = var.dest_cidr
    gateway_id = aws_internet_gateway.pro_igw.id
}

resource "aws_subnet" "pro_public_subnet" {
    count = length(var.public_cidr)
    vpc_id = aws_vpc.pro_vpc.id
    cidr_block = var.public_cidr[count.index]
    map_public_ip_on_launch = true
    availability_zone = data.availability_zone.available.name[count.index]

    tag = {
        Name = "pro_public_${random_id.random.dec}-${count.index + 1}"
    }
}

resource "aws_subnet" "pro_private_subnet" {
    count = length(var.private_cidr)
    vpc_id = aws_vpc.pro_vpc.id
    cidr_block = var.public_cidr[count.index]
    availability_zone = data.availability_zone.available.name[count.index]

    tag = {
        Name = "pro_private_${random_id.random.dec}-${count.index + 1}"
    }
}