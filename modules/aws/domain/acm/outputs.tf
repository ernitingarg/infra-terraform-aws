output "acm_certificate_arn" {
  description = "The ARN of the AWS ACM certificate"
  value       = aws_acm_certificate.acm_certificate.arn
}
