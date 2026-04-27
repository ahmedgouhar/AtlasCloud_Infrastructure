# output "website_endpoint" {
#   value = aws_s3_bucket.cleanora_bucket.website_endpoint
# }

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.cleanora_bucket.bucket_regional_domain_name
}
output "alb_logs_bucket_name" {
  value = aws_s3_bucket.alb_logs.bucket
}

output "alb_logs_bucket_arn" {
  value = aws_s3_bucket.alb_logs.arn
}
