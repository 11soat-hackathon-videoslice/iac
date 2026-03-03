variable "api_name" {
  type        = string
  description = "Name of the API Gateway REST API"
}

variable "authorizer_name" {
  type        = string
  description = "Name of the Cognito authorizer"
}

variable "cognito_user_pool_arn" {
  type        = string
  description = "ARN of the Cognito User Pool for authorization"
}

variable "stage_name" {
  type        = string
  description = "Name of the API Gateway stage"
  default     = "prd"
}

variable "disable_execute_api_endpoint" {
  type        = bool
  description = "Disable the default execute-api endpoint"
  default     = false
}

variable "lambda_url_generator_arn" {
  type        = string
  description = "ARN of the URL generator Lambda function"
}

variable "lambda_url_generator_invoke_arn" {
  type        = string
  description = "Invoke ARN of the URL generator Lambda function"
}

variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name for video slice"
}

variable "api_gateway_role_arn" {
  type        = string
  description = "IAM role ARN for API Gateway to access DynamoDB"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to API Gateway resources"
  default     = {}
}
