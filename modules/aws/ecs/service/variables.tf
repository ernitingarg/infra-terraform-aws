variable "env" {
  description = "The environment name"
}

variable "project_name" {
  description = "The project name"
}

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "vpc_subnet_public_ids" {
  description = "List of public subnet IDs for ecs service"
  type        = list(string)
}

variable "ecs_cluster_id" {
  description = "The ECS cluster ID"
}

variable "ecs_cluster_name" {
  description = "The ECS cluster name"
  type        = string
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
}

variable "ecs_container_name" {
  description = "The name of the ECS container"
}

variable "ecs_container_port" {
  description = "Port to allow inbound traffic to the ECS container"
  type        = number
}

variable "ecs_task_definition_arn" {
  description = "The ARN of the ECS task definition"
}

variable "lb_security_group_id" {
  description = "The security group ID for the load balancer"
}

variable "lb_target_group_arn" {
  description = "The ARN of the load balancer target group"
}
