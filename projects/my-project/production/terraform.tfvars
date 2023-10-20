region       = "ap-northeast-1"
env          = "prod"
project_name = "my-project"

network_subnets_public     = ["10.0.1.0/24", "10.0.2.0/24"]
network_subnets_private    = ["10.0.3.0/24", "10.0.4.0/24"]
network_availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]

apex_domain_name = "vote.app"

ecs_backend_service_name         = "backend"
ecs_backend_sub_domain_name      = "backend.production.vote.app"
ecs_backend_container_cpu        = 256
ecs_backend_container_memory     = 512
ecs_backend_container_name       = "backend"
ecs_backend_container_port       = 3000
ecs_backend_container_base_url   = "/api"
ecs_backend_container_health_url = "/api/health"

rds_provider          = "postgresql"
rds_engine            = "postgres"
rds_engine_version    = "15.3"
rds_instance_class    = "db.t3.micro"
rds_allocated_storage = 20
rds_port              = 5432
rds_dbname            = "postgresdb"
rds_username          = "prod_dbadmin"
rds_allow_multi_az    = false
