variable "route53_domain_name" {
  description = "The domain name for the Route 53 hosted zone to be imported"
}

variable "route53_sub_domain_name" {
  description = "The subdomain name for the Route 53 record"
}

variable "route53_alias_target_domain_name" {
  description = "The target domain name for the alias"
}

variable "route53_alias_target_zone_id" {
  description = "The target Route 53 hosted zone ID for the alias"
}
