

resource "aws_instance" "web" {
  count = var.instance_count

  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_ids[count.index]

  vpc_security_group_ids = [var.sg_id]

  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello from CLEANORA " > /var/www/html/index.html
              EOF

  tags = {
    Name = "cleanora-ec2"
  }
}
