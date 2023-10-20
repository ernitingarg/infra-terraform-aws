output "s3_bucket_id" {
  value       = aws_s3_bucket.s3_bucket.id
  description = "The ID of the S3 bucket."
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.s3_bucket.arn
  description = "The ARN of the S3 bucket."
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.s3_bucket.bucket
  description = "The unique name of the S3 bucket."
}
