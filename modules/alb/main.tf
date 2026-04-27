resource "aws_lb" "cleanora_lb" {
  name               = "cleanora-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.sg_id]
  enable_http2 = true
  tags = {
    Name = "cleanora-alb"
  }
  access_logs {
  bucket = var.alb_logs_bucket
  prefix  = "alb-logs"
  enabled = true
}
}
resource "aws_lb_target_group" "tg" {
  name     = "cleanora-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  # 👇important for ASG
  target_type = "instance"

  # 👇 for production
  deregistration_delay = 30

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.cleanora_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# resource "aws_lb_target_group_attachment" "attach" {
#   count = length(var.instance_ids)

#   target_group_arn = aws_lb_target_group.tg.arn
#   target_id        = var.instance_ids[count.index]
#   port             = 80
# }