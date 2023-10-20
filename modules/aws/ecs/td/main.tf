locals {
  tags = {
    Environment = var.env
    ProjectName = var.project_name
  }
  name                         = "${var.project_name}-${var.env}-${var.ecs_task_definition_name}"
  ecs_task_execution_role_name = "${local.name}-ecsTaskExecutionRole"
  ecr_permission_policy_name   = "${local.name}-ecrPermissionPolicy"
  ecs_task_definition_name     = "${local.name}-ecsTaskDefinition"
}

resource "aws_iam_role" "iam_role_task_execution" {
  name        = local.ecs_task_execution_role_name
  description = "ECS Task Execution Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com",
        },
      },
    ],
  })

  tags = merge(local.tags, {
    Name = local.ecs_task_execution_role_name
  })
}

resource "aws_iam_policy" "iam_policy_ecr" {
  name        = local.ecr_permission_policy_name
  description = "ECR permissions policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
        ],
        Effect   = "Allow",
        Resource = "*",
      }
    ],
  })

  tags = merge(local.tags, {
    Name = local.ecr_permission_policy_name
  })
}

resource "aws_iam_role_policy_attachment" "esc_task_execution_role_ecr_policy_attachment" {
  policy_arn = aws_iam_policy.iam_policy_ecr.arn
  role       = aws_iam_role.iam_role_task_execution.name
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = local.ecs_task_definition_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_container_cpu
  memory                   = var.ecs_container_memory
  execution_role_arn       = aws_iam_role.iam_role_task_execution.arn
  task_role_arn            = aws_iam_role.iam_role_task_execution.arn
  container_definitions = jsonencode(
    [{
      name        = var.ecs_container_name
      image       = var.ecs_container_image
      essential   = true
      command     = [],
      volumes     = [],
      mountPoints = [],
      environment = var.ecs_container_environments
      secret      = var.ecs_container_secrets
      portMappings = [{
        protocol      = "tcp"
        containerPort = var.ecs_container_port
        hostPort      = var.ecs_container_port
      }]
    }]
  )

  tags = merge(local.tags, {
    Name = local.ecs_task_definition_name
  })
}
