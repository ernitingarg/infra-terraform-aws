output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.vpc.id
}

output "subnet_public_ids" {
  description = "A list of public subnet IDs."
  value       = aws_subnet.subnet_public[*].id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway for public subnets."
  value       = aws_internet_gateway.internet_gateway.id
}

output "subnet_private_ids" {
  description = "A list of private subnet IDs."
  value       = aws_subnet.subnet_private[*].id
}
