output "vpc_id" {
  value = module.vpc.vpc_id
}

output "route53_record_name_backend" {
  value = module.ecs-app-stack-backend.route53_record_name
}
