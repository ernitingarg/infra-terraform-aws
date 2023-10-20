variable "env" {
  description = "Environment name"
}

variable "project_name" {
  description = "Project name"
}

variable "subnets_public" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "subnets_private" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}
