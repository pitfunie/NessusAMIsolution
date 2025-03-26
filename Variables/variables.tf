variable "region" {}
variable "vpc_cidr_block" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "nessus_ami" {}
variable "instance_type" { default = "t2.micro" }
