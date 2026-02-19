output "rest_api_id" {
  value       = aws_api_gateway_rest_api.this.id
  description = "API Gateway REST API ID"
}

output "rest_api_arn" {
  value       = aws_api_gateway_rest_api.this.arn
  description = "API Gateway REST API ARN"
}

output "rest_api_root_resource_id" {
  value       = aws_api_gateway_rest_api.this.root_resource_id
  description = "API Gateway REST API root resource ID"
}

output "stage_name" {
  value       = aws_api_gateway_stage.this.stage_name
  description = "API Gateway Stage Name"
}

output "stage_arn" {
  value       = aws_api_gateway_stage.this.arn
  description = "API Gateway Stage ARN"
}

output "invoke_url" {
  value       = aws_api_gateway_stage.this.invoke_url
  description = "API Gateway Invoke URL"
}

output "authorizer_id" {
  value       = aws_api_gateway_authorizer.this.id
  description = "API Gateway Authorizer ID"
}

output "deployment_id" {
  value       = aws_api_gateway_deployment.this.id
  description = "API Gateway Deployment ID"
}
