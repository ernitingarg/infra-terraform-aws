output "ecs_cluster_id" {
  description = "The ID of the created ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster.id
}

output "ecs_cluster_name" {
  description = "The name of the created ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster.name
}

output "ecs_cluster_arn" {
  description = "The ARN of the created ECS cluster"
  value       = aws_ecs_cluster.ecs_cluster.arn
}
