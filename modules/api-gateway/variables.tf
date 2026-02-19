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

variable "tags" {
  type        = map(string)
  description = "Tags to apply to API Gateway resources"
  default     = {}
}
