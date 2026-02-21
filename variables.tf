#========================================================================================#
#                                 Global VARIABLES                                       #
#========================================================================================#

variable "prefix_name" {
  type        = string
  description = "Prefix name for resources"
}
variable "environment_name" {
  type        = string
  description = "Environment name"
}

#========================================================================================#
#                               COGNITO VARIABLES                                       #
#========================================================================================#

variable "cognito_user_pool_name" {
  type        = string
  description = "Name of the Cognito User Pool"
}

variable "cognito_client_name" {
  type        = string
  description = "Name of the Cognito User Pool Client"
}

variable "cognito_callback_urls" {
  type        = list(string)
  description = "Callback URLs for Cognito"
  default     = []
}

variable "cognito_auto_verified_attributes" {
  type        = list(string)
  description = "Attributes to be auto-verified"
  default     = ["email"]
}

variable "cognito_deletion_protection" {
  type        = string
  description = "Deletion protection for the user pool"
  default     = "ACTIVE"
}

variable "cognito_mfa_configuration" {
  type        = string
  description = "MFA configuration"
  default     = "OFF"
}

variable "cognito_user_pool_tier" {
  type        = string
  description = "User pool tier"
  default     = "ESSENTIALS"
}

variable "cognito_username_attributes" {
  type        = list(string)
  description = "Attributes to use as username"
  default     = ["email"]
}

variable "cognito_allow_admin_create_user_only" {
  type        = bool
  description = "Allow only admin to create users"
  default     = false
}

variable "cognito_password_minimum_length" {
  type        = number
  description = "Minimum password length"
  default     = 8
}

variable "cognito_password_history_size" {
  type        = number
  description = "Password history size"
  default     = 0
}

variable "cognito_password_require_lowercase" {
  type        = bool
  description = "Require lowercase in password"
  default     = true
}

variable "cognito_password_require_numbers" {
  type        = bool
  description = "Require numbers in password"
  default     = true
}

variable "cognito_password_require_symbols" {
  type        = bool
  description = "Require symbols in password"
  default     = true
}

variable "cognito_password_require_uppercase" {
  type        = bool
  description = "Require uppercase in password"
  default     = true
}

variable "cognito_temporary_password_validity_days" {
  type        = number
  description = "Temporary password validity in days"
  default     = 7
}

variable "cognito_allowed_first_auth_factors" {
  type        = list(string)
  description = "Allowed first authentication factors"
  default     = ["PASSWORD"]
}

variable "cognito_username_case_sensitive" {
  type        = bool
  description = "Username case sensitivity"
  default     = false
}

variable "cognito_access_token_validity" {
  type        = number
  description = "Access token validity in minutes"
  default     = 60
}

variable "cognito_allowed_oauth_flows" {
  type        = list(string)
  description = "Allowed OAuth flows"
  default     = ["code"]
}

variable "cognito_allowed_oauth_flows_user_pool_client" {
  type        = bool
  description = "Enable OAuth flows for user pool client"
  default     = true
}

variable "cognito_allowed_oauth_scopes" {
  type        = list(string)
  description = "Allowed OAuth scopes"
  default     = ["email", "openid", "phone"]
}

variable "cognito_auth_session_validity" {
  type        = number
  description = "Auth session validity in minutes"
  default     = 3
}

variable "cognito_explicit_auth_flows" {
  type        = list(string)
  description = "Explicit authentication flows"
  default     = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_AUTH", "ALLOW_USER_SRP_AUTH"]
}

variable "cognito_id_token_validity" {
  type        = number
  description = "ID token validity in minutes"
  default     = 60
}

variable "cognito_logout_urls" {
  type        = list(string)
  description = "Logout URLs"
  default     = []
}

variable "cognito_refresh_token_validity" {
  type        = number
  description = "Refresh token validity in days"
  default     = 5
}

variable "cognito_supported_identity_providers" {
  type        = list(string)
  description = "Supported identity providers"
  default     = ["COGNITO"]
}

variable "cognito_tags" {
  type        = map(string)
  description = "Tags to apply to Cognito resources"
  default     = {}
}

#========================================================================================#
#                               DYNAMODB VARIABLES                                      #
#========================================================================================#

variable "dynamodb_video_slice_table_name" {
  type        = string
  description = "Name of the VideoSlice DynamoDB table"
}

variable "dynamodb_idempotency_table_name" {
  type        = string
  description = "Name of the Idempotency DynamoDB table"
}

variable "dynamodb_notification_web_table_name" {
  type        = string
  description = "Name of the NotificationWeb DynamoDB table"
}

variable "dynamodb_deletion_protection_enabled" {
  type        = bool
  description = "Enable deletion protection for DynamoDB tables"
  default     = false
}

variable "dynamodb_stream_enabled" {
  type        = bool
  description = "Enable DynamoDB streams"
  default     = true
}

variable "dynamodb_point_in_time_recovery" {
  type        = bool
  description = "Enable point-in-time recovery"
  default     = false
}

variable "dynamodb_tags" {
  type        = map(string)
  description = "Tags to apply to DynamoDB tables"
  default     = {}
}

#========================================================================================#
#                          API GATEWAY  VARIABLES                                        #
#========================================================================================#

variable "apigw_api_name" {
  type        = string
  description = "Name of the API Gateway REST API"
}

variable "apigw_authorizer_name" {
  type        = string
  description = "Name of the Cognito authorizer"
}

variable "apigw_cognito_user_pool_arn" {
  type        = string
  description = "ARN of the Cognito User Pool for authorization"
}

variable "apigw_stage_name" {
  type        = string
  description = "Name of the API Gateway stage"
  default     = "prd"
}

variable "apigw_disable_execute_api_endpoint" {
  type        = bool
  description = "Disable the default execute-api endpoint"
  default     = false
}

variable "apigw_tags" {
  type        = map(string)
  description = "Tags to apply to API Gateway resources"
  default     = {}
}

#========================================================================================#
#                               EVENTBRIDGE VARIABLES                                   #
#========================================================================================#

variable "eventbridge_bus_name" {
  type        = string
  description = "Name of the EventBridge event bus"
}

variable "eventbridge_bus_description" {
  type        = string
  description = "Description of the EventBridge event bus"
  default     = ""
}

variable "eventbridge_enable_log_config" {
  type        = bool
  description = "Enable log configuration for event bus"
  default     = true
}

variable "eventbridge_redirect_role_name" {
  type        = string
  description = "Name of the IAM role for event redirection"
}

variable "eventbridge_redirect_role_description" {
  type        = string
  description = "Description of the IAM role"
  default     = ""
}

variable "eventbridge_redirect_policy_name" {
  type        = string
  description = "Name of the IAM policy for event redirection"
}

variable "eventbridge_rule_name" {
  type        = string
  description = "Name of the EventBridge rule"
}

variable "eventbridge_rule_description" {
  type        = string
  description = "Description of the EventBridge rule"
  default     = ""
}

variable "eventbridge_rule_state" {
  type        = string
  description = "State of the EventBridge rule (ENABLED or DISABLED)"
  default     = "DISABLED"
}

variable "eventbridge_s3_bucket_name" {
  type        = string
  description = "S3 bucket name to monitor for events"
}

variable "eventbridge_s3_object_prefix" {
  type        = string
  description = "S3 object prefix to filter events"
  default     = "uploads/"
}

variable "eventbridge_dlq_arn" {
  type        = string
  description = "ARN of the Dead Letter Queue (SQS)"
}

variable "eventbridge_tags" {
  type        = map(string)
  description = "Tags to apply to EventBridge resources"
  default     = {}
}


variable "eventbridge_pipe_name" {
  type        = string
  description = "Name of the EventBridge Pipe"
}

variable "eventbridge_pipe_role_name" {
  type        = string
  description = "Name of the IAM role for Pipes"
}

variable "eventbridge_pipe_role_description" {
  type        = string
  description = "Description of the Pipes IAM role"
  default     = ""
}

variable "eventbridge_pipe_dynamodb_policy_name" {
  type        = string
  description = "Name of the DynamoDB policy for Pipes"
}

variable "eventbridge_pipe_events_policy_name" {
  type        = string
  description = "Name of the EventBridge policy for Pipes"
}

variable "eventbridge_pipe_sqs_policy_name" {
  type        = string
  description = "Name of the SQS policy for Pipes"
}

variable "eventbridge_pipe_desired_state" {
  type        = string
  description = "Desired state of the pipe (RUNNING or STOPPED)"
  default     = "RUNNING"
}

variable "eventbridge_dynamodb_stream_arn" {
  type        = string
  description = "ARN of the DynamoDB stream"
}

variable "eventbridge_pipe_dlq_arn" {
  type        = string
  description = "ARN of the SQS DLQ for Pipes"
}

variable "eventbridge_pipe_log_group_arn" {
  type        = string
  description = "ARN of the CloudWatch Log Group for Pipes"
}

#========================================================================================#
#                                 LAMBDA VARIABLES                                       #
#========================================================================================#

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
  description = "Lambda functions configuration"
}

variable "lambda_aliases" {
  type = map(object({
    function_name    = string
    alias_name       = string
    function_version = string
  }))
  description = "Lambda aliases configuration"
}

variable "lambda_event_mappings" {
  type = map(object({
    function_name    = string
    event_source_arn = string
    batch_size       = number
    enabled          = bool
    response_types   = list(string)
  }))
  description = "Lambda event source mappings configuration"
}

variable "lambda_invoke_configs" {
  type = map(object({
    function_name = string
    dlq_arn       = string
  }))
  description = "Lambda function event invoke configurations"
}

variable "lambda_permissions" {
  type = map(object({
    function_name = string
    statement_id  = string
    principal     = string
    source_arn    = string
  }))
  description = "Lambda permissions configuration"
}

variable "lambda_iam_roles" {
  type = map(object({
    role_name        = string
    description      = string
    path             = string
    inline_policies  = map(string)
    managed_policies = list(string)
  }))
  description = "IAM roles for Lambda functions"
}

variable "lambda_iam_policies" {
  type = map(object({
    policy_name = string
    path        = string
    description = string
    policy_file = string
  }))
  description = "IAM policies for Lambda functions"
}

variable "lambda_tags" {
  type        = map(string)
  description = "Tags to apply to Lambda resources"
  default     = {}
}

#========================================================================================#
#                                   SQS VARIABLES                                        #
#========================================================================================#

variable "sqs_queues" {
  type = map(object({
    name                       = string
    delay_seconds              = number
    max_message_size           = number
    message_retention_seconds  = number
    receive_wait_time_seconds  = number
    visibility_timeout_seconds = number
    dlq_arn                    = string
    max_receive_count          = number
  }))
  description = "SQS queues configuration"
}

variable "sqs_dlq_queues" {
  type = map(object({
    name                       = string
    visibility_timeout_seconds = number
    eventbridge_rule_arn       = string
  }))
  description = "SQS DLQ queues configuration"
}

variable "sqs_tags" {
  type        = map(string)
  description = "Tags to apply to SQS resources"
  default     = {}
}

#========================================================================================#
#                               APPSYNC VARIABLES                                       #
#========================================================================================#

variable "appsync_api_name" {
  type        = string
  description = "Name of the AppSync GraphQL API"
}

variable "appsync_authentication_type" {
  type        = string
  description = "Authentication type for the API"
  default     = "API_KEY"
}

variable "appsync_introspection_config" {
  type        = string
  description = "Introspection configuration"
  default     = "ENABLED"
}

variable "appsync_xray_enabled" {
  type        = bool
  description = "Enable X-Ray tracing"
  default     = false
}

variable "appsync_cognito_user_pool_id" {
  type        = string
  description = "Cognito User Pool ID for authentication"
}

variable "appsync_cognito_aws_region" {
  type        = string
  description = "AWS region for Cognito User Pool"
  default     = "us-east-1"
}

variable "appsync_tags" {
  type        = map(string)
  description = "Tags to apply to AppSync resources"
  default     = {}
}

#========================================================================================#
#                               AMPLIFY VARIABLES                                       #
#========================================================================================#

variable "amplify_app_name" {
  type        = string
  description = "Name of the Amplify app"
}

variable "amplify_repository" {
  type        = string
  description = "GitHub repository URL"
}

variable "amplify_iam_service_role_arn" {
  type        = string
  description = "IAM service role ARN for Amplify"
}

variable "amplify_environment_variables" {
  type        = map(string)
  description = "Environment variables for the app"
  default     = {}
}

variable "react_app_api_download_url" {
  type        = string
  description = "React App API Download URL"
  default     = ""
}

variable "react_app_api_gateway_url" {
  type        = string
  description = "React App API Gateway URL"
  default     = ""
}

variable "react_app_api_list_by_user_id" {
  type        = string
  description = "React App API List by User ID"
  default     = ""
}

variable "react_app_api_upload_metadata" {
  type        = string
  description = "React App API Upload Metadata"
  default     = ""
}

variable "react_app_api_upload_url" {
  type        = string
  description = "React App API Upload URL"
  default     = ""
}

variable "react_app_appsync_endpoint" {
  type        = string
  description = "React App AppSync Endpoint"
  default     = ""
}

variable "react_app_aws_region" {
  type        = string
  description = "React App AWS Region"
  default     = ""
}

variable "react_app_dynamodb_table_name" {
  type        = string
  description = "React App DynamoDB Table Name"
  default     = ""
}

variable "react_app_max_images" {
  type        = string
  description = "React App Max Images"
  default     = ""
}

variable "react_app_max_retry" {
  type        = string
  description = "React App Max Retry"
  default     = ""
}

variable "react_app_user_pool_client_id" {
  type        = string
  description = "React App User Pool Client ID"
  default     = ""
}

variable "react_app_user_pool_id" {
  type        = string
  description = "React App User Pool ID"
  default     = ""
}

variable "amplify_enable_branch_auto_build" {
  type        = bool
  description = "Enable automatic build on branch push"
  default     = false
}

variable "amplify_enable_basic_auth" {
  type        = bool
  description = "Enable basic authentication"
  default     = false
}

variable "lambda_notification_web_appsync_url" {
  type        = string
  description = "AppSync URL for notification-web Lambda"
  default     = ""
}

variable "lambda_notification_web_log_level" {
  type        = string
  description = "Log level for notification-web Lambda"
  default     = ""
}

variable "lambda_video_slice_aws_region" {
  type        = string
  description = "AWS Region for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_s3_bucket_name" {
  type        = string
  description = "S3 bucket name for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_event_bus_name" {
  type        = string
  description = "Event bus name for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_dir_uploads" {
  type        = string
  description = "Uploads directory for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_dir_finished" {
  type        = string
  description = "Finished directory for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_dir_tmp" {
  type        = string
  description = "Temp directory for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_max_workers" {
  type        = string
  description = "Max workers for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_retry_backoff_factor" {
  type        = string
  description = "Retry backoff factor for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_role_arn" {
  type        = string
  description = "Schedule event role ARN for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_dlq" {
  type        = string
  description = "Schedule event DLQ for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_log_level" {
  type        = string
  description = "Log level for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_powertools_service_name" {
  type        = string
  description = "Powertools service name for video-slice Lambda"
  default     = ""
}

variable "lambda_video_slice_powertools_metrics_namespace" {
  type        = string
  description = "Powertools metrics namespace for video-slice Lambda"
  default     = ""
}

variable "lambda_notification_email_cognito_user_pool" {
  type        = string
  description = "Cognito User Pool for notification-email Lambda"
  default     = ""
}

variable "lambda_notification_email_aws_region" {
  type        = string
  description = "AWS Region for notification-email Lambda"
  default     = ""
}

variable "lambda_notification_email_from_email" {
  type        = string
  description = "From email for notification-email Lambda"
  default     = ""
}

variable "lambda_notification_email_logo_url" {
  type        = string
  description = "Logo URL for notification-email Lambda"
  default     = ""
}

variable "lambda_notification_email_dashboard_url" {
  type        = string
  description = "Dashboard URL for notification-email Lambda"
  default     = ""
}

variable "lambda_notification_email_timezone" {
  type        = string
  description = "Timezone for notification-email Lambda"
  default     = ""
}

variable "lambda_notification_email_template" {
  type        = string
  description = "Email template path for notification-email Lambda"
  default     = ""
}

variable "lambda_url_generator_aws_region" {
  type        = string
  description = "AWS Region for url-generator Lambda"
  default     = ""
}

variable "lambda_url_generator_s3_signature_version" {
  type        = string
  description = "S3 signature version for url-generator Lambda"
  default     = ""
}

variable "lambda_url_generator_s3_bucket_name" {
  type        = string
  description = "S3 bucket name for url-generator Lambda"
  default     = ""
}

variable "lambda_url_generator_s3_url_download_expiration" {
  type        = string
  description = "S3 URL download expiration for url-generator Lambda"
  default     = ""
}

variable "lambda_url_generator_s3_url_upload_expiration" {
  type        = string
  description = "S3 URL upload expiration for url-generator Lambda"
  default     = ""
}

variable "lambda_url_generator_s3_bucket_dir_uploads" {
  type        = string
  description = "S3 bucket uploads directory for url-generator Lambda"
  default     = ""
}

variable "lambda_url_generator_s3_bucket_dir_finished" {
  type        = string
  description = "S3 bucket finished directory for url-generator Lambda"
  default     = ""
}
