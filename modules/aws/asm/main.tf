locals {
  tags = {
    Name        = "${var.project_name}-${var.env}-${var.asm_secret_name}"
    Environment = var.env
    ProjectName = var.project_name
  }
}

resource "aws_secretsmanager_secret" "secretsmanager_secret" {
  name                    = local.tags.Name
  recovery_window_in_days = 0

  tags = local.tags
}

resource "aws_secretsmanager_secret_version" "secretsmanager_secret_version" {
  secret_id     = aws_secretsmanager_secret.secretsmanager_secret.id
  secret_string = jsonencode(var.asm_secret_data)
}
