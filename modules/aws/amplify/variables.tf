variable "env" {
  description = "The environment name"
}

variable "project_name" {
  description = "The project name"
}

variable "amplify_github_repository" {
  description = "The github repo url"
}

variable "amplify_github_access_token" {
  description = "The github access token to connect github repo"
}

variable "amplify_github_repository_branch_name" {
  description = "AWS Amplify App Repo Branch Name"
  default     = "main"
}

variable "amplify_app_name" {
  description = "AWS Amplify App Name"
}

variable "amplify_domain_name" {
  description = "AWS Amplify Domain Name"
  default     = "amplifyapp.com"
}

