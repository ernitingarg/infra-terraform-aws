
data "aws_route53_zone" "route53_zone" {
  name         = var.route53_domain_name
  private_zone = false
}

resource "aws_route53_record" "route53_record" {
  name    = var.route53_sub_domain_name
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  type    = "A"

  alias {
    name                   = var.route53_alias_target_domain_name
    zone_id                = var.route53_alias_target_zone_id
    evaluate_target_health = true
  }
}
