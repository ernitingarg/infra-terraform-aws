output "ecs_service_arn" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.ecs_service.id
}

output "ecs_security_group_id" {
  description = "The ID of the security group associated with the ECS service"
  value       = module.sg_ecs.sg_id
}
