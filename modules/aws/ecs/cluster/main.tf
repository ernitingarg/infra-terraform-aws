locals {
  tags = {
    Environment = var.env
    ProjectName = var.project_name
  }
  ecs_cluster_name = "${var.project_name}-${var.env}-cluster"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = local.ecs_cluster_name

  tags = merge(local.tags, {
    Name = local.ecs_cluster_name
  })
}
