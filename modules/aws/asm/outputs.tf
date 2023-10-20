
output "asm_secret_arn" {
  description = "The ARN of the AWS Secrets Manager secret"
  value       = aws_secretsmanager_secret.secretsmanager_secret.arn
}

output "asm_secret_name" {
  description = "The name of the AWS Secrets Manager secret"
  value       = aws_secretsmanager_secret.secretsmanager_secret.name
}

output "asm_secret_version_id" {
  description = "The ID of the AWS Secrets Manager Secret Version"
  value       = aws_secretsmanager_secret_version.secretsmanager_secret_version.id
}
