variable "api_name" {
  type        = string
  description = "Name of the AppSync GraphQL API"
}

variable "authentication_type" {
  type        = string
  description = "Authentication type for the API"
  default     = "API_KEY"
}

variable "introspection_config" {
  type        = string
  description = "Introspection configuration"
  default     = "ENABLED"
}

variable "xray_enabled" {
  type        = bool
  description = "Enable X-Ray tracing"
  default     = false
}

variable "cognito_user_pool_id" {
  type        = string
  description = "Cognito User Pool ID for authentication"
}

variable "cognito_aws_region" {
  type        = string
  description = "AWS region for Cognito User Pool"
  default     = "us-east-1"
}

variable "appsync_service_role_arn" {
  type        = string
  description = "IAM role ARN for AppSync to access DynamoDB"
}

variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name for notifications"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
