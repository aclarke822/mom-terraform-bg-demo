locals {
  production_dns_name = (var.production_color == "blue" ?
    module.deployment_group_blue.alb_dns_name :
  module.deployment_group_green.alb_dns_name)

  production_dns_zone_id = (var.production_color == "blue" ?
    module.deployment_group_blue.alb_dns_zone_id :
  module.deployment_group_green.alb_dns_zone_id)

  production_alb_listner_arn = (var.production_color == "blue" ?
    module.deployment_group_blue.alb_listner_arn :
  module.deployment_group_green.alb_listner_arn)
}

data "aws_route53_zone" "zone" {
  name         = var.hosted_zone_name
  private_zone = false
}

resource "aws_route53_record" "dns_record_production" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "production.${data.aws_route53_zone.zone.name}"
  type    = "A"

  alias {
    name                   = local.production_dns_name
    zone_id                = local.production_dns_zone_id
    evaluate_target_health = true
  }
}
