resource "aws_vpc" "cleanora" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "cleanora-vpc"
  }
}