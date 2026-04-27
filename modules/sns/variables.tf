variable "topic_name" {
  type        = string
  description = "SNS topic name"
}

variable "email_endpoints" {
  type        = list(string)
  description = "List of emails to receive alerts"
  default     = []
}