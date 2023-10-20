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
  description = "List of public subnet IDs for the load balancer"
  type        = list(string)
}

variable "lb_name" {
  description = "The name of the load balancer"
}


variable "lb_target_group_port" {
  description = "The port for the load balancer target group"
  type        = number
}

variable "lb_target_group_healthcheck_path" {
  description = "The path used for health checks in the load balancer target group"
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate for HTTPS"
}
