locals {
  tags = {
    Environment = var.env
    ProjectName = var.project_name
  }

  name                   = "${var.project_name}-${var.env}-${var.lb_name}"
  lb_name                = local.name
  lb_target_group_name   = local.name
  lb_http_listener_name  = "${local.lb_name}-lb-listener-http"
  lb_https_listener_name = "${local.lb_name}-lb-listener-https"
  lb_security_group_name = "${local.name}-sg-lb"
}

module "sg_lg" {
  source       = "../network/sg/external"
  env          = var.env
  project_name = var.project_name
  sg_name      = local.lb_security_group_name
  vpc_id       = var.vpc_id
}

resource "aws_lb" "lb" {
  name                             = local.lb_name
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [module.sg_lg.sg_id]
  subnets                          = var.vpc_subnet_public_ids
  ip_address_type                  = "ipv4" # fargate managed ec2
  enable_cross_zone_load_balancing = true

  tags = merge(local.tags, {
    Name = "${local.lb_name}-lb"
  })
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = local.lb_target_group_name
  port        = var.lb_target_group_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = "3"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200,301"
    timeout             = "5"
    path                = coalesce(var.lb_target_group_healthcheck_path, "/")
    port                = "traffic-port"
  }

  tags = merge(local.tags, {
    Name = "${local.lb_target_group_name}-lb-target-group"
  })
}

resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = merge(local.tags, {
    Name = local.lb_http_listener_name
  })
}

resource "aws_lb_listener" "lb_listener_https" {
  load_balancer_arn = aws_lb.lb.id
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    type             = "forward"
  }

  tags = merge(local.tags, {
    Name = local.lb_https_listener_name
  })
}
