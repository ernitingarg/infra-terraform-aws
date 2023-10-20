output "sg_id" {
  description = "The ID of the internal security group"
  value       = aws_security_group.security_group_internal.id
}

