### Create ecr
module "ecs_ecr" {
  source             = "../ecr"
  env                = var.env
  project_name       = var.project_name
  ecr_container_name = var.ecs_container_name
}

### Create acm ssl/tls certificate for load balancer
module "ecs_acm" {
  source                  = "../domain/acm"
  env                     = var.env
  project_name            = var.project_name
  route53_domain_name     = var.apex_domain_name
  route53_sub_domain_name = var.ecs_sub_domain_name
}

### Create load balancer for ecs service
module "ecs_lb" {
  source                           = "../alb"
  env                              = var.env
  project_name                     = var.project_name
  vpc_id                           = var.vpc_id
  vpc_subnet_public_ids            = var.subnet_public_ids
  lb_name                          = var.ecs_service_name
  lb_target_group_port             = var.ecs_container_port
  lb_target_group_healthcheck_path = var.ecs_container_health_url
  acm_certificate_arn              = module.ecs_acm.acm_certificate_arn
}

### Create task definition for ecs service
module "ecs_td" {
  source                     = "../ecs/td"
  env                        = var.env
  project_name               = var.project_name
  ecs_task_definition_name   = var.ecs_service_name
  ecs_container_cpu          = var.ecs_container_cpu
  ecs_container_memory       = var.ecs_container_memory
  ecs_container_name         = var.ecs_container_name
  ecs_container_image        = "${module.ecs_ecr.ecr_repository_url}:latest"
  ecs_container_port         = var.ecs_container_port
  ecs_container_environments = var.ecs_container_environments
  ecs_container_secrets      = var.ecs_container_secrets
}

### Create ecs service
module "ecs_service" {
  source                  = "../ecs/service"
  env                     = var.env
  project_name            = var.project_name
  vpc_id                  = var.vpc_id
  vpc_subnet_public_ids   = var.subnet_public_ids
  ecs_service_name        = var.ecs_service_name
  ecs_container_name      = var.ecs_container_name
  ecs_container_port      = var.ecs_container_port
  ecs_cluster_id          = var.ecs_cluster_id
  ecs_cluster_name        = var.ecs_cluster_name
  lb_security_group_id    = module.ecs_lb.lb_security_group_id
  lb_target_group_arn     = module.ecs_lb.lb_target_group_arn
  ecs_task_definition_arn = module.ecs_td.ecs_task_definition_arn
}

### Create route53 for the load balancer
module "ecs_route53" {
  source                           = "../domain/route53"
  route53_domain_name              = var.apex_domain_name
  route53_sub_domain_name          = var.ecs_sub_domain_name
  route53_alias_target_domain_name = module.ecs_lb.lb_dns_name
  route53_alias_target_zone_id     = module.ecs_lb.lb_zone_id
}
