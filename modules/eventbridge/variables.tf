variable "event_bus_name" {
  type        = string
  description = "Name of the EventBridge event bus"
}

variable "event_bus_description" {
  type        = string
  description = "Description of the EventBridge event bus"
  default     = ""
}

variable "enable_log_config" {
  type        = bool
  description = "Enable log configuration for event bus"
  default     = true
}

variable "redirect_role_name" {
  type        = string
  description = "Name of the IAM role for event redirection"
}

variable "redirect_role_description" {
  type        = string
  description = "Description of the IAM role"
  default     = ""
}

variable "redirect_policy_name" {
  type        = string
  description = "Name of the IAM policy for event redirection"
}

variable "event_rule_name" {
  type        = string
  description = "Name of the EventBridge rule"
}

variable "event_rule_description" {
  type        = string
  description = "Description of the EventBridge rule"
  default     = ""
}

variable "event_rule_state" {
  type        = string
  description = "State of the EventBridge rule (ENABLED or DISABLED)"
  default     = "DISABLED"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name to monitor for events"
}

variable "s3_object_prefix" {
  type        = string
  description = "S3 object prefix to filter events"
  default     = "uploads/"
}

variable "dlq_arn" {
  type        = string
  description = "ARN of the Dead Letter Queue (SQS)"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to EventBridge resources"
  default     = {}
}


# Pipes Variables
variable "pipe_name" {
  type        = string
  description = "Name of the EventBridge Pipe"
}

variable "pipe_role_name" {
  type        = string
  description = "Name of the IAM role for Pipes"
}

variable "pipe_role_description" {
  type        = string
  description = "Description of the Pipes IAM role"
  default     = ""
}

variable "pipe_dynamodb_policy_name" {
  type        = string
  description = "Name of the DynamoDB policy for Pipes"
}

variable "pipe_events_policy_name" {
  type        = string
  description = "Name of the EventBridge policy for Pipes"
}

variable "pipe_sqs_policy_name" {
  type        = string
  description = "Name of the SQS policy for Pipes"
}

variable "pipe_desired_state" {
  type        = string
  description = "Desired state of the pipe (RUNNING or STOPPED)"
  default     = "RUNNING"
}

variable "dynamodb_stream_arn" {
  type        = string
  description = "ARN of the DynamoDB stream"
}

variable "pipe_dlq_arn" {
  type        = string
  description = "ARN of the SQS DLQ for Pipes"
}

variable "pipe_log_group_arn" {
  type        = string
  description = "ARN of the CloudWatch Log Group for Pipes"
}
