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
  description = "The name of the internal security group"
}

variable "sg_allowed_ingress_port" {
  description = "The inbound port for allowing traffic"
}

variable "sg_allowed_ingress_sg_id" {
  description = "Security group ID allowed for inbound traffic"
}
