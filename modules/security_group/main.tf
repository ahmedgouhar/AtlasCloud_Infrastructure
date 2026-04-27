resource "aws_security_group" "web_sg" {
  name        = "cleanora-web-sg"
  description = "Security group for ALB + ASG instances"
  vpc_id      = var.vpc_id

  tags = {
    Name = "cleanora-web-sg"
  }
}

# Allow HTTP from anywhere (ALB traffic)
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# resource "aws_vpc_security_group_ingress_rule" "http" {
#   security_group_id = aws_security_group.web_sg.id

#   cidr_ipv4   = "0.0.0.0/0"
#   ip_protocol = "tcp"
#   from_port   = 80
#   to_port     = 80
# }

# resource "aws_vpc_security_group_ingress_rule" "ssh" {
#   security_group_id = aws_security_group.web_sg.id

#   cidr_ipv4   = var.my_ip  
#   ip_protocol = "tcp"
#   from_port   = 22
#   to_port     = 22
# }
# resource "aws_vpc_security_group_egress_rule" "all" {
#   security_group_id = aws_security_group.web_sg.id

#   cidr_ipv4   = "0.0.0.0/0"
#   ip_protocol = "-1"
# }








  