variable "env" {
  description = "The environment name"
}

variable "project_name" {
  description = "The project name"
}

variable "ecs_task_definition_name" {
  description = "The name of the ECS task definition"
}

variable "ecs_container_cpu" {
  description = "The CPU units for the ECS container"
}

variable "ecs_container_memory" {
  description = "The memory for the ECS container"
}

variable "ecs_container_name" {
  description = "The name of the ECS container"
}

variable "ecs_container_image" {
  description = "The Docker image for the ECS container"
}

variable "ecs_container_environments" {
  description = "A list of environment variables for the ECS task container"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "ecs_container_secrets" {
  description = "A list of secrets to pass to the ECS task container."
  type = list(object({
    name      = string
    value     = optional(string)
    valueFrom = optional(string)
  }))
}

variable "ecs_container_port" {
  description = "The port to expose on the ECS container"
}
