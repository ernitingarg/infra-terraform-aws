output "ecs_task_execution_role_arn" {
  description = "The ARN of the created IAM role for ECS task execution"
  value       = aws_iam_role.iam_role_task_execution.arn
}

output "ecr_permission_policy_arn" {
  description = "The ARN of the IAM policy for ECR permissions"
  value       = aws_iam_policy.iam_policy_ecr.arn
}

output "ecs_task_definition_arn" {
  description = "The ARN of the ECS task definition"
  value       = aws_ecs_task_definition.ecs_task_definition.arn
}
