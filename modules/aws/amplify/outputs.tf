output "amplify_app_id" {
  description = "The ID of the AWS Amplify application."
  value       = aws_amplify_app.amplify_app.id
}

output "amplify_domain_association_id" {
  description = "The ID of the Amplify domain association."
  value       = aws_amplify_domain_association.amplify_domain_association.id
}
