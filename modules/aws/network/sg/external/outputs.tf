output "sg_id" {
  description = "The ID of the external security group"
  value       = aws_security_group.security_group_external.id
}
