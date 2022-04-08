resource "aws_route53_record" "record" {
  zone_id = var.hosted_zone_id
  name = var.record_name
  type = var.record_type

  alias {
    name = var.record_alias_name
    zone_id = var.record_alis_zone_id
    evaluate_target_health = false
  }
}