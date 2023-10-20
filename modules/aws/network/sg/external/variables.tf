variable "env" {
  description = "The environment name"
}

variable "project_name" {
  description = "The project name"
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
}

variable "sg_name" {
  description = "The name of the external security group"
}
