locals {
  tags = {
    Environment = var.env
    ProjectName = var.project_name
  }
  rg_name = "${var.project_name}-${var.env}-rg"
}

resource "aws_resourcegroups_group" "resourcegroups_group" {
  name = local.rg_name

  resource_query {
    query = jsonencode({
      ResourceTypeFilters = ["AWS::AllSupported"],
      TagFilters = [
        {
          Key    = "Environment",
          Values = [var.env]
        },
        {
          Key    = "ProjectName",
          Values = [var.project_name]
        }
      ]
    })
  }

  tags = merge(local.tags, {
    Name = local.rg_name
  })
}
