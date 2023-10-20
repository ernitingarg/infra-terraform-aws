terraform {
  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  region = var.region
}

module "staging" {
  source                           = "../common"
  env                              = var.env
  project_name                     = var.project_name
  network_subnets_public           = var.network_subnets_public
  network_subnets_private          = var.network_subnets_private
  network_availability_zones       = var.network_availability_zones
  apex_domain_name                 = var.apex_domain_name
  ecs_backend_service_name         = var.ecs_backend_service_name
  ecs_backend_sub_domain_name      = var.ecs_backend_sub_domain_name
  ecs_backend_container_cpu        = var.ecs_backend_container_cpu
  ecs_backend_container_memory     = var.ecs_backend_container_memory
  ecs_backend_container_name       = var.ecs_backend_container_name
  ecs_backend_container_port       = var.ecs_backend_container_port
  ecs_backend_container_base_url   = var.ecs_backend_container_base_url
  ecs_backend_container_health_url = var.ecs_backend_container_health_url
  rds_provider                     = var.rds_provider
  rds_engine                       = var.rds_engine
  rds_engine_version               = var.rds_engine_version
  rds_instance_class               = var.rds_instance_class
  rds_allocated_storage            = var.rds_allocated_storage
  rds_port                         = var.rds_port
  rds_dbname                       = var.rds_dbname
  rds_username                     = var.rds_username
  rds_allow_multi_az               = var.rds_allow_multi_az
}
