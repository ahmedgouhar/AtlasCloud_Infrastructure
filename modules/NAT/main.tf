resource "aws_eip" "nat" {}

resource "aws_nat_gateway" "cleanora" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id
  
}