# resource "aws_cloudwatch_metric_alarm" "cpu_high" {
#   alarm_name          = "${var.asg_name}-cpu-high"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = 2

#   metric_name = "CPUUtilization"
#   namespace   = "AWS/EC2"
#   period      = 60
#   statistic   = "Average"

#   threshold = var.cpu_high_threshold
#   alarm_actions = [aws_autoscaling_policy.scale_out.arn]

#   dimensions = {
#     AutoScalingGroupName = var.asg_name
#   }
# }
# resource "aws_cloudwatch_metric_alarm" "cpu_low" {
#   alarm_name          = "${var.asg_name}-cpu-low"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = 2
#   alarm_actions = [aws_autoscaling_policy.scale_in.arn]

#   metric_name = "CPUUtilization"
#   namespace   = "AWS/EC2"
#   period      = 60
#   statistic   = "Average"

#   threshold = var.cpu_low_threshold

#   dimensions = {
#     AutoScalingGroupName = var.asg_name
    
#   }
# }
resource "aws_cloudwatch_metric_alarm" "asg_unhealthy" {
  alarm_name          = "${var.asg_name}-unhealthy"
  comparison_operator = "LessThanThreshold"

  evaluation_periods = 2
  metric_name        = "GroupInServiceInstances"
  namespace          = "AWS/AutoScaling"
  period             = 60
  statistic          = "Average"

  threshold = 1

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}

resource "aws_autoscaling_policy" "cpu_target" {
  name                   = "cpu-target-tracking"
  policy_type           = "TargetTrackingScaling"
  autoscaling_group_name = var.asg_name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 60.0
  }
}
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "cleanora-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,

        properties = {
          title = "ASG CPU Utilization",
          metrics = [
            ["AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.asg_name]
          ],
          period = 60,
          stat   = "Average",
          region = "eu-central-1"
        }
      },

      {
        type = "metric",
        x = 0,
        y = 6,
        width = 12,
        height = 6,

        properties = {
          title = "ASG Instances",
          metrics = [
            ["AWS/AutoScaling", "GroupInServiceInstances", "AutoScalingGroupName", var.asg_name]
          ],
          period = 60,
          stat   = "Average",
          region = data.aws_region.current.id
        }
      }
    ]
  })
}
resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/cleanora/app"
  retention_in_days = 14

  tags = {
    Environment = "prod"
    Project     = "cleanora"
  }
}
resource "aws_cloudwatch_log_group" "system_logs" {
  name              = "/cleanora/system"
  retention_in_days = 14
}
resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name          = "alb-5xx-errors"
  comparison_operator = "GreaterThanThreshold"

  metric_name = "HTTPCode_ELB_5XX_Count"
  namespace   = "AWS/ApplicationELB"

  period            = 60
  evaluation_periods = 2
  statistic         = "Sum"

  threshold = 10

  dimensions = {
  LoadBalancer = var.alb_arn
  
}
  }
