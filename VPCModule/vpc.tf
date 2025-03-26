resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "Main VPC"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}
