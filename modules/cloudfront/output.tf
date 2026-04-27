
output "cdn_arn" {
  value = aws_cloudfront_distribution.cdn.arn
}
output "domain_name_cloud" {
  value = aws_cloudfront_distribution.cdn.domain_name
}
