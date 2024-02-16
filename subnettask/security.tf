resource "aws_security_group" "pro_sg" {
    name = "public-sucurity-group"
    description = "security group for public instance"
    vpc_id = aws_vpc.pro_vpc.id
}

resource "aws_security_group_rule" "remove_all" {
    type = "ingress"
    count = 0
    to_port = 0
    from_port = 65535
    protocol = "-1"
    cidr_blocks = [ var.dest_cidr ]
    security_group_id = aws_security_group.pro_sg.id
}

resource "aws_security_group_rule" "ingress_all" {
    type = "ingress"
    count = length(var.allow_ports_open)
    to_port = var.allow_ports_open[count.index]
    from_port = var.allow_ports_open[count.index]
    protocol = "tcp"
    cidr_blocks = [ var.dest_cidr ]
    security_group_id = aws_security_group.pro_sg.id
}

resource "aws_security_group_rule" "egress_all" {
    type = "egress"
    to_port = 0
    from_port = 0
    protocol = "-1"
    cidr_blocks = [ var.dest_cidr ]
    security_group_id = aws_security_group.pro_sg.id
}