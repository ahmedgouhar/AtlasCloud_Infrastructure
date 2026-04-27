resource "aws_internet_gateway" "cleanora" {
  vpc_id = var.vpc_id

  tags = {
    Name = "cleanora-igw"
  }
}

