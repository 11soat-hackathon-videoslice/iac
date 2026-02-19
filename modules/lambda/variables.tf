variable "lambda_functions" {
  type = map(object({
    function_name   = string
    handler         = string
    runtime         = string
    memory_size     = number
    timeout         = number
    ephemeral_size  = number
    description     = string
    role_arn        = string
    environment     = map(string)
    zip_file        = string
  }))
}

variable "lambda_aliases" {
  type = map(object({
    function_name    = string
    alias_name       = string
    function_version = string
  }))
}

variable "lambda_event_mappings" {
  type = map(object({
    function_name    = string
    event_source_arn = string
    batch_size       = number
    enabled          = bool
    response_types   = list(string)
  }))
}

variable "lambda_invoke_configs" {
  type = map(object({
    function_name = string
    dlq_arn       = string
  }))
}

variable "lambda_permissions" {
  type = map(object({
    function_name = string
    statement_id  = string
    principal     = string
    source_arn    = string
  }))
}

variable "iam_roles" {
  type = map(object({
    role_name        = string
    description      = string
    path             = string
    inline_policies  = map(string)
    managed_policies = list(string)
  }))
}

variable "iam_policies" {
  type = map(object({
    policy_name = string
    path        = string
    description = string
    policy_file = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
