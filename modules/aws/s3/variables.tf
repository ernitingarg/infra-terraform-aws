variable "env" {
  description = "The environment name"
}

variable "project_name" {
  description = "The project name"
}

variable "s3_bucket_suffix_name" {
  description = "The suffix name of s3 bucket"
}

variable "s3_create_public_bucket" {
  description = "Set to true to create a public S3 bucket, false for private."
  type        = bool
  default     = false
}
