locals {
  tags = {
    Environment = var.env
    ProjectName = var.project_name
  }
  name                         = "${var.project_name}-${var.env}-${var.ecs_service_name}"
  ecs_service_name             = "${local.name}-service"
  ecs_security_group_name      = "${local.name}-sg-ecs"
  ecs_auto_scaling_target_name = "${local.name}-ecs-auto_scaling_target"
}

module "sg_ecs" {
  source                   = "../../network/sg/internal"
  env                      = var.env
  project_name             = var.project_name
  sg_name                  = local.ecs_security_group_name
  vpc_id                   = var.vpc_id
  sg_allowed_ingress_port  = var.ecs_container_port
  sg_allowed_ingress_sg_id = var.lb_security_group_id
}

resource "aws_ecs_service" "ecs_service" {
  name                               = local.ecs_service_name
  cluster                            = var.ecs_cluster_id
  task_definition                    = var.ecs_task_definition_arn
  launch_type                        = "FARGATE"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0   # optional for autoscaling
  deployment_maximum_percent         = 200 # optional for autoscaling

  network_configuration {
    subnets          = var.vpc_subnet_public_ids
    security_groups  = [module.sg_ecs.sg_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = var.ecs_container_name
    container_port   = var.ecs_container_port
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }

  tags = merge(local.tags, {
    Name = local.ecs_service_name
  })
}

resource "aws_appautoscaling_target" "appautoscaling_target" {
  min_capacity       = 1
  max_capacity       = 4
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.ecs_service.name}"
  service_namespace  = "ecs"
  scalable_dimension = "ecs:service:DesiredCount"

  tags = merge(local.tags, {
    Name = local.ecs_auto_scaling_target_name
  })
}

resource "aws_appautoscaling_policy" "appautoscaling_policy_memory" {
  name               = "memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.appautoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.appautoscaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.appautoscaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = 60
  }
}

resource "aws_appautoscaling_policy" "appautoscaling_policy_cpu" {
  name               = "cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.appautoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.appautoscaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.appautoscaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 60
  }
}
