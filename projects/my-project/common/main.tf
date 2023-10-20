## Create a vpc
module "vpc" {
  source             = "../../../modules/aws/network/vpc"
  env                = var.env
  project_name       = var.project_name
  subnets_public     = var.network_subnets_public
  subnets_private    = var.network_subnets_private
  availability_zones = var.network_availability_zones
}

## Create random password for db
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()_=?~"
}

## Create cluster for ecs services
module "cluster" {
  source       = "../../../modules/aws/ecs/cluster"
  env          = var.env
  project_name = var.project_name
}

## Create ecs for backend service
module "ecs-app-stack-backend" {
  source                   = "../../../modules/aws/ecs-app-stack"
  env                      = var.env
  project_name             = var.project_name
  vpc_id                   = module.vpc.vpc_id
  subnet_public_ids        = module.vpc.subnet_public_ids
  subnet_private_ids       = module.vpc.subnet_private_ids
  apex_domain_name         = var.apex_domain_name
  ecs_cluster_id           = module.cluster.ecs_cluster_id
  ecs_cluster_name         = module.cluster.ecs_cluster_name
  ecs_service_name         = var.ecs_backend_service_name
  ecs_sub_domain_name      = var.ecs_backend_sub_domain_name
  ecs_container_cpu        = var.ecs_backend_container_cpu
  ecs_container_memory     = var.ecs_backend_container_memory
  ecs_container_name       = var.ecs_backend_container_name
  ecs_container_port       = var.ecs_backend_container_port
  ecs_container_health_url = var.ecs_backend_container_health_url
  ecs_container_environments = [
    {
      name  = "API_SERVER_PORT"
      value = var.ecs_backend_container_port
    },
    {
      name  = "API_BASE_PATH"
      value = var.ecs_backend_container_base_url
    },
  ]
  ecs_container_secrets = [
    {
      name  = "DATABASE_URL"
      value = "${var.rds_provider}://${var.rds_username}:${random_password.password.result}@${var.rds_engine}:${var.rds_port}/${var.rds_dbname}"
    },
  ]
}

## Create RDS primary and replica
module "rds" {
  source                 = "../../../modules/aws/rds"
  env                    = var.env
  project_name           = var.project_name
  vpc_id                 = module.vpc.vpc_id
  vpc_subnet_private_ids = module.vpc.subnet_private_ids
  ecs_security_group_id  = module.ecs-app-stack-backend.ecs_security_group_id
  rds_engine             = var.rds_engine
  rds_engine_version     = var.rds_engine_version
  rds_instance_class     = var.rds_instance_class
  rds_allocated_storage  = var.rds_allocated_storage
  rds_port               = var.rds_port
  rds_dbname             = var.rds_dbname
  rds_username           = var.rds_username
  rds_password           = random_password.password.result
  rds_allow_multi_az     = var.rds_allow_multi_az
}

## Create Secret manager for storing db credentials
module "asm_rds" {
  source          = "../../../modules/aws/asm"
  env             = var.env
  project_name    = var.project_name
  asm_secret_name = "db-credentials"
  asm_secret_data = {
    dbname           = var.rds_dbname
    username         = var.rds_username
    password         = random_password.password.result
    engine           = var.rds_engine
    primary_endpoint = module.rds.rds_instance_primary_endpoint
  }
}

## Create resource group
module "rg" {
  source       = "../../../modules/aws/rg"
  env          = var.env
  project_name = var.project_name
}
