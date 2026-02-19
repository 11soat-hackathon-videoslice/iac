variable "prefix_name" {
  type        = string
  description = "Prefix for resource names"
}

variable "environment_name" {
  type        = string
  description = "Environment name"
}

variable "user_pool_name" {
  type        = string
  description = "Name of the Cognito User Pool"
}

variable "auto_verified_attributes" {
  type        = list(string)
  description = "Attributes to be auto-verified"
  default     = ["email"]
}

variable "deletion_protection" {
  type        = string
  description = "Deletion protection for the user pool"
  default     = "ACTIVE"
}

variable "mfa_configuration" {
  type        = string
  description = "MFA configuration"
  default     = "OFF"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "user_pool_tier" {
  type        = string
  description = "User pool tier"
  default     = "ESSENTIALS"
}

variable "username_attributes" {
  type        = list(string)
  description = "Attributes to use as username"
  default     = ["email"]
}

variable "allow_admin_create_user_only" {
  type        = bool
  description = "Allow only admin to create users"
  default     = false
}

variable "password_minimum_length" {
  type        = number
  description = "Minimum password length"
  default     = 8
}

variable "password_history_size" {
  type        = number
  description = "Password history size"
  default     = 0
}

variable "password_require_lowercase" {
  type        = bool
  description = "Require lowercase in password"
  default     = true
}

variable "password_require_numbers" {
  type        = bool
  description = "Require numbers in password"
  default     = true
}

variable "password_require_symbols" {
  type        = bool
  description = "Require symbols in password"
  default     = true
}

variable "password_require_uppercase" {
  type        = bool
  description = "Require uppercase in password"
  default     = true
}

variable "temporary_password_validity_days" {
  type        = number
  description = "Temporary password validity in days"
  default     = 7
}

variable "allowed_first_auth_factors" {
  type        = list(string)
  description = "Allowed first authentication factors"
  default     = ["PASSWORD"]
}

variable "username_case_sensitive" {
  type        = bool
  description = "Username case sensitivity"
  default     = false
}

variable "client_name" {
  type        = string
  description = "Name of the Cognito User Pool Client"
}

variable "access_token_validity" {
  type        = number
  description = "Access token validity in minutes"
  default     = 60
}

variable "allowed_oauth_flows" {
  type        = list(string)
  description = "Allowed OAuth flows"
  default     = ["code"]
}

variable "allowed_oauth_flows_user_pool_client" {
  type        = bool
  description = "Enable OAuth flows for user pool client"
  default     = true
}

variable "allowed_oauth_scopes" {
  type        = list(string)
  description = "Allowed OAuth scopes"
  default     = ["email", "openid", "phone"]
}

variable "auth_session_validity" {
  type        = number
  description = "Auth session validity in minutes"
  default     = 3
}

variable "callback_urls" {
  type        = list(string)
  description = "Callback URLs"
  default     = []
}

variable "explicit_auth_flows" {
  type        = list(string)
  description = "Explicit authentication flows"
  default     = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_AUTH", "ALLOW_USER_SRP_AUTH"]
}

variable "id_token_validity" {
  type        = number
  description = "ID token validity in minutes"
  default     = 60
}

variable "logout_urls" {
  type        = list(string)
  description = "Logout URLs"
  default     = []
}

variable "refresh_token_validity" {
  type        = number
  description = "Refresh token validity in days"
  default     = 5
}

variable "supported_identity_providers" {
  type        = list(string)
  description = "Supported identity providers"
  default     = ["COGNITO"]
}
