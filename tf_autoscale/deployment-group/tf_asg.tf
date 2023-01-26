resource "aws_autoscaling_group" "bluegreen" {
  name                      = "asg-${var.blue_or_green}"
  vpc_zone_identifier       = [aws_subnet.primary.id, aws_subnet.secondary.id]
  desired_capacity          = 0
  max_size                  = 0
  min_size                  = 0
  target_group_arns         = [aws_alb_target_group.group.arn]
  health_check_grace_period = 180

  launch_template {
    id      = var.lt_id
    version = var.lt_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 0
      skip_matching          = true
    }
  }
}

resource "aws_alb" "alb" {
  name            = "alb-${var.blue_or_green}"
  security_groups = [var.sg_id]
  subnets         = [aws_subnet.primary.id, aws_subnet.secondary.id]

/*   access_logs {
    bucket  = "aclarke822"
    prefix  = "alb-${var.blue_or_green}"
    enabled = true
  } */
}

resource "aws_alb_target_group" "group" {
  name_prefix = "${var.blue_or_green}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  protocol_version = "HTTP2"

  stickiness {
    type = "lb_cookie"
  }

  health_check {
    path     = "/"
    port     = 80
    interval = 60
    protocol = "HTTP"
    timeout  = 20
  }

  lifecycle {
      create_before_destroy = true
    }
}

resource "aws_alb_listener" "listener_https" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn


  default_action {
    target_group_arn = aws_alb_target_group.group.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "listener_http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

data "aws_route53_zone" "zone" {
  name         = var.hosted_zone_name
  private_zone = false
}

resource "aws_route53_record" "dns_record" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "${var.blue_or_green}.${data.aws_route53_zone.zone.name}"
  type    = "A"

  alias {
    name                   = aws_alb.alb.dns_name
    zone_id                = aws_alb.alb.zone_id
    evaluate_target_health = true
  }
}