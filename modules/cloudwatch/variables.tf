variable "asg_name" {
  description = "Auto Scaling Group Name"
  type        = string
}

variable "cpu_high_threshold" {
  default = 70
}

variable "cpu_low_threshold" {
  default = 30
}
variable "alarm_actions" {
}

variable "alb_arn" {
  type = string
}