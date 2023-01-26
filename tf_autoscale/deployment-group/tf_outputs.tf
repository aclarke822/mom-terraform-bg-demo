output "alb_dns_name" {
  value = aws_alb.alb.dns_name
}

output "alb_dns_zone_id" {
  value = aws_alb.alb.zone_id
}

output "alb_listner_arn" {
  value = aws_alb_listener.listener_https.arn
}