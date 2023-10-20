variable "env" {
  description = "The environment name"
}

variable "project_name" {
  description = "The project name"
}

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "vpc_subnet_private_ids" {
  description = "List of private subnet IDs for RDS instance"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "The security group ID for the ECS service."
}

variable "rds_engine" {
  description = "The RDS database engine (e.g., mysql, postgres, etc.)."
}

variable "rds_engine_version" {
  description = "The version of the RDS database engine."
}

variable "rds_instance_class" {
  description = "The instance class for the RDS instance (e.g., db.t2.micro)."
}

variable "rds_allocated_storage" {
  description = "The amount of allocated storage for the RDS instance."
  type        = number
}

variable "rds_port" {
  description = "The port number to allow for RDS security group ingress."
}

variable "rds_dbname" {
  description = "The name of the RDS database."
}

variable "rds_username" {
  description = "The username for accessing the RDS database."
}

variable "rds_password" {
  description = "The password for accessing the RDS database."
  sensitive   = true
}

variable "rds_allow_multi_az" {
  description = "Whether to allow Multi-AZ deployment for the RDS instance"
  type        = bool
  default     = false
}