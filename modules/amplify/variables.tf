variable "app_name" {
  type        = string
  description = "Name of the Amplify app"
}

variable "repository" {
  type        = string
  description = "GitHub repository URL"
}

variable "iam_service_role_arn" {
  type        = string
  description = "IAM service role ARN for Amplify"
}

variable "environment_variables" {
  type        = map(string)
  description = "Environment variables for the app"
  default     = {}
}

variable "enable_branch_auto_build" {
  type        = bool
  description = "Enable automatic build on branch push"
  default     = false
}

variable "enable_basic_auth" {
  type        = bool
  description = "Enable basic authentication"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
