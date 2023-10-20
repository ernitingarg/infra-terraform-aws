locals {
  tags = {
    Environment = var.env
    ProjectName = var.project_name
  }
  s3_bucket_unique_name = "${var.project_name}-${var.env}-${var.s3_bucket_suffix_name}"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = local.s3_bucket_unique_name

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = false
  }

  tags = merge(local.tags, {
    Name = "${local.s3_bucket_unique_name}-s3"
  })

  depends_on = [aws_s3_bucket.s3_bucket]
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [aws_s3_bucket.s3_bucket]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_server_side_encryption_configuration" {
  bucket = aws_s3_bucket.s3_bucket.id
  count  = var.s3_create_public_bucket ? 0 : 1

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

  depends_on = [aws_s3_bucket.s3_bucket]
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  count                   = var.s3_create_public_bucket ? 0 : 1
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [aws_s3_bucket.s3_bucket]
}
