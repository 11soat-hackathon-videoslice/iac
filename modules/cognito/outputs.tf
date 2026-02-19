output "user_pool_id" {
  value       = aws_cognito_user_pool.this.id
  description = "Cognito User Pool ID"
}

output "user_pool_arn" {
  value       = aws_cognito_user_pool.this.arn
  description = "Cognito User Pool ARN"
}

output "user_pool_client_id" {
  value       = aws_cognito_user_pool_client.this.id
  description = "Cognito User Pool Client ID"
}

output "user_pool_endpoint" {
  value       = aws_cognito_user_pool.this.endpoint
  description = "Cognito User Pool Endpoint"
}
