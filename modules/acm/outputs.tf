output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
}
output "certificate_val_arn" {
  value = aws_acm_certificate_validation.cert_val.certificate_arn
}