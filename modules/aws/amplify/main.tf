locals {
  tags = {
    Name        = "${var.project_name}-${var.env}-${var.amplify_app_name}"
    Environment = var.env
    ProjectName = var.project_name
  }
}

resource "aws_amplify_app" "amplify_app" {
  name         = local.tags.Name
  repository   = var.amplify_github_repository
  access_token = var.amplify_github_access_token

  tags = merge(local.tags, {
    Name = "${local.tags.Name}-amplify"
  })
}

resource "aws_amplify_branch" "amplify_branch" {
  app_id      = aws_amplify_app.amplify_app.id
  branch_name = var.amplify_github_repository_branch_name

  tags = merge(local.tags, {
    Name = "${local.tags.Name}-amplify-branch"
  })
}

resource "aws_amplify_domain_association" "amplify_domain_association" {
  app_id                = aws_amplify_app.amplify_app.id
  domain_name           = var.amplify_domain_name
  wait_for_verification = false

  sub_domain {
    branch_name = aws_amplify_branch.amplify_branch.branch_name
    prefix      = var.amplify_github_repository_branch_name
  }
}
