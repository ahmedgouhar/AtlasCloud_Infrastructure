resource "aws_launch_template" "cleanora" {
  name_prefix   = "cleanora-"
  image_id      = var.ami
  instance_type = "t3.micro"

  vpc_security_group_ids = [var.sg_id]

  iam_instance_profile {
    name = var.instance_profile_name
  }

  user_data = base64encode(<<-EOF
#!/bin/bash
yum update -y
yum install -y httpd amazon-cloudwatch-agent

systemctl enable httpd
systemctl start httpd

mkdir -p /opt/aws/amazon-cloudwatch-agent/bin/

cat > /opt/aws/amazon-cloudwatch-agent/bin/config.json <<'CONFIG'
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/messages",
            "log_group_name": "/cleanora/system",
            "log_stream_name": "{instance_id}"
          },
          {
            "file_path": "/var/log/httpd/access_log",
            "log_group_name": "/cleanora/app",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
CONFIG

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json \
-s
EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "cleanora-asg-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "cleanora" {
  name                = "cleanora-asg"
  min_size            = 1
  desired_capacity    = 2
  max_size            = 4

  vpc_zone_identifier = var.private_subnet_ids

  health_check_type         = "ELB"
  health_check_grace_period = 60

  target_group_arns = [var.target_group_arn]
  launch_template {
    id      = aws_launch_template.cleanora.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "cleanora-asg"
    propagate_at_launch = true
  }
}