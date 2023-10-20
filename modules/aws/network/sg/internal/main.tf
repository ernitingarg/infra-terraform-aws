locals {
  tags = {
    Name        = var.sg_name
    Environment = var.env
    ProjectName = var.project_name
  }
}

resource "aws_security_group" "security_group_internal" {
  name        = local.tags.Name
  description = "Internal security group definition."
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow inbound traffic for a specific port"
    protocol        = "tcp"
    from_port       = var.sg_allowed_ingress_port
    to_port         = var.sg_allowed_ingress_port
    security_groups = [var.sg_allowed_ingress_sg_id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}
