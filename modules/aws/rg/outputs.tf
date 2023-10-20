output "resource_group_id" {
  description = "The ID of the AWS Resource Group."
  value       = aws_resourcegroups_group.resourcegroups_group.id
}
