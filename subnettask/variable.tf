variable vpc_cidr {
    type = string
    default = "10.0.1.0/16"
}

variable dest_cidr {
    type = string
    default = "0.0.0.0/0"
}

variable region {
  type = string
  default = "ap-south-1"
}

variable bucket {
    type = string
    default = "my-tf-test-bucket-"  
}

variable "allow_ports_open" {
  type    = list(string)
  default = [22, 80, 443]
}

variable "main_instance_type" {
  type = string
  default = "t2.micro"
}

variable "main_vol_size" {
  type = number
  default = 8
}