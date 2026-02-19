output "app_id" {
  value       = aws_amplify_app.this.id
  description = "Amplify App ID"
}

output "app_arn" {
  value       = aws_amplify_app.this.arn
  description = "Amplify App ARN"
}

output "default_domain" {
  value       = aws_amplify_app.this.default_domain
  description = "Default domain for the Amplify app"
}
