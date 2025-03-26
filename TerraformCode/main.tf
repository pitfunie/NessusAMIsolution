provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
  region     = var.region
}

module "public_subnet" {
  source     = "./modules/subnet"
  vpc_id     = module.vpc.vpc_id
  cidr_block = var.public_subnet_cidr
  is_public  = true
}

module "private_subnet" {
  source     = "./modules/subnet"
  vpc_id     = module.vpc.vpc_id
  cidr_block = var.private_subnet_cidr
  is_public  = false
}

resource "aws_instance" "nessus" {
  ami           = var.nessus_ami
  instance_type = var.instance_type
  subnet_id     = module.public_subnet.subnet_id

  tags = {
    Name = "Nessus Instance"
  }
}

output "instance_id" {
  value = aws_instance.nessus.id
}
