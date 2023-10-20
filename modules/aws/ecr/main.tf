locals {
  tags = {
    Environment = var.env
    ProjectName = var.project_name
  }
  ecr_repository_name = "${var.project_name}-${var.env}-${var.ecr_container_name}"
}

resource "aws_ecr_repository" "ecr_repository" {
  name                 = local.ecr_repository_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(local.tags, {
    Name = "${local.ecr_repository_name}-ecr"
  })
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.ecr_repository.name

  policy = jsonencode({
    rules = [
      {
        rulePriority : 1,
        description : "Expire untagged images older than 15 days",
        selection : {
          tagStatus : "untagged",
          countType : "sinceImagePushed",
          countUnit : "days",
          countNumber : 15
        },
        action : {
          type : "expire"
        }
      }
    ]
  })
}
