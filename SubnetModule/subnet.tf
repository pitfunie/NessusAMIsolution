resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = var.is_public

  tags = {
    Name = "Subnet"
  }
}

output "subnet_id" {
  value = aws_subnet.subnet.id
}
