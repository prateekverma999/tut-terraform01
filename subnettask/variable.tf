variable vpc_cidr {
    type = string
    default = "10.123.0.0/16"
}

variable dest_cidr {
    type = string
    default = "0.0.0.0/0"
}

variable public_cidr {
    type = list(string)
    default = ["10.124.1.0/24", "10.124.3.0/24"]
}

variable private_cidr {
    type = list(string)
    default = ["10.124.2.0/24", "10.124.4.0/24"]
}