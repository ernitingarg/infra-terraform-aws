output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.lb.dns_name
}

output "lb_zone_id" {
  description = "The Zone ID of the load balancer."
  value       = aws_lb.lb.zone_id
}

output "lb_target_group_arn" {
  description = "The ARN of the target group of the load balancer."
  value       = aws_lb_target_group.lb_target_group.arn
}

output "lb_security_group_id" {
  description = "The ID of the security group associated with the AWS LB"
  value       = module.sg_lg.sg_id
}

output "lb_listener_http_arn" {
  description = "The ARN of the HTTP listener on the load balancer"
  value       = aws_lb_listener.lb_listener_http.arn
}

output "lb_listener_https_arn" {
  description = "The ARN of the HTTPS listener on the load balancer"
  value       = aws_lb_listener.lb_listener_https.arn
}
