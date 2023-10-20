output "vpc_id" {
  value = module.staging.vpc_id
}

output "route53_record_name_backend" {
  value = module.staging.route53_record_name_backend
}
