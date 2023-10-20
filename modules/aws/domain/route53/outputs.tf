output "route53_record_name" {
  description = "The name of the Route 53 record"
  value       = aws_route53_record.route53_record.name
}

output "route53_record_type" {
  description = "The type of the Route 53 record"
  value       = aws_route53_record.route53_record.type
}

output "route53_record_zone_id" {
  description = "The zone ID of the Route 53 record"
  value       = aws_route53_record.route53_record.zone_id
}
