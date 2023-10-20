locals {
  tags = {
    Environment = var.env
    ProjectName = var.project_name
  }
  name                      = "${var.project_name}-${var.env}"
  rds_subnet_group_name     = "${local.name}-rds-subnet-group"
  rds_security_group_name   = "${local.name}-sg-rds"
  rds_primary_instance_name = "${local.name}-rds-primary"
  rds_replica_instance_name = "${local.name}-rds-replica"
}

module "sg_rds" {
  source                   = "../network/sg/internal"
  env                      = var.env
  project_name             = var.project_name
  sg_name                  = local.rds_security_group_name
  vpc_id                   = var.vpc_id
  sg_allowed_ingress_port  = var.rds_port
  sg_allowed_ingress_sg_id = var.ecs_security_group_id // Allow only ecs service
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = local.rds_subnet_group_name
  subnet_ids = var.vpc_subnet_private_ids

  tags = merge(local.tags, {
    Name = local.rds_subnet_group_name
  })
}

resource "aws_db_instance" "db_instance_primary" {
  identifier              = local.rds_primary_instance_name
  allocated_storage       = var.rds_allocated_storage
  engine                  = var.rds_engine
  engine_version          = var.rds_engine_version
  instance_class          = var.rds_instance_class
  db_name                 = var.rds_dbname
  username                = var.rds_username
  password                = var.rds_password
  skip_final_snapshot     = true
  storage_encrypted       = true
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [module.sg_rds.sg_id]
  multi_az                = var.rds_allow_multi_az
  backup_retention_period = 5

  tags = merge(local.tags, {
    Name = local.rds_primary_instance_name
  })
}

