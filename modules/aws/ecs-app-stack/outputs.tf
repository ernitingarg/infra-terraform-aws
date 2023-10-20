output "route53_record_name" {
  value = module.ecs_route53.route53_record_name
}

output "ecs_security_group_id" {
  value = module.ecs_service.ecs_security_group_id
}
