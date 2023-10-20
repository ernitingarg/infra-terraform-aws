variable "env" {
  description = "The environment name"
}

variable "project_name" {
  description = "The project name"
}

variable "asm_secret_name" {
  description = "The name of the AWS Secrets Manager secret"
}

variable "asm_secret_data" {
  description = "A map of secret data to store in AWS Secrets Manager"
  type        = map(string)
  default = {
    username = "default_username"
    password = "default_password"
  }
  sensitive = true
}

