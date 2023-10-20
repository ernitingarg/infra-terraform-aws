output "rds_instance_primary_endpoint" {
  description = "The endpoint URL of the primary RDS instance."
  value       = aws_db_instance.db_instance_primary.endpoint
}

output "rds_security_group_id" {
  description = "The ID of the security group associated with the RDS instance."
  value       = module.sg_rds.sg_id
}
