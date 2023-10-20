variable "env" {}
variable "project_name" {}
variable "region" {}

variable "network_subnets_public" {}
variable "network_subnets_private" {}
variable "network_availability_zones" {}

variable "apex_domain_name" {}

# backend
variable "ecs_backend_service_name" {}
variable "ecs_backend_sub_domain_name" {}
variable "ecs_backend_container_cpu" {}
variable "ecs_backend_container_memory" {}
variable "ecs_backend_container_name" {}
variable "ecs_backend_container_port" {}
variable "ecs_backend_container_base_url" {}
variable "ecs_backend_container_health_url" {}

# rds
variable "rds_provider" {}
variable "rds_engine" {}
variable "rds_engine_version" {}
variable "rds_instance_class" {}
variable "rds_allocated_storage" {}
variable "rds_port" {}
variable "rds_dbname" {}
variable "rds_username" {}
variable "rds_allow_multi_az" {}
