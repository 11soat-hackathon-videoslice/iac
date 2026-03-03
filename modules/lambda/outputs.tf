output "lambda_function_arns" {
  description = "ARNs of Lambda functions"
  value       = { for k, v in aws_lambda_function.this : k => v.arn }
}

output "lambda_function_invoke_arns" {
  description = "Invoke ARNs of Lambda functions"
  value       = { for k, v in aws_lambda_function.this : k => v.invoke_arn }
}

output "lambda_function_names" {
  description = "Names of Lambda functions"
  value       = { for k, v in aws_lambda_function.this : k => v.function_name }
}

output "iam_role_arns" {
  description = "ARNs of IAM roles"
  value       = { for k, v in aws_iam_role.this : k => v.arn }
}
