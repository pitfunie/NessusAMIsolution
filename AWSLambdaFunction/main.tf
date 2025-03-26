provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = "main-vpc"
  }
}

module "public_subnet" {
  source     = "./modules/subnet"
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  tags       = var.tags
}

module "private_subnet" {
  source     = "./modules/subnet"
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  tags       = var.tags
}

resource "aws_security_group" "example" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "example-sg"
  }
}
