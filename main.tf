#========================================================================================#
#                                COGNITO MODULE                                         #
#========================================================================================#

module "cognito" {
  source = "./modules/cognito"

  prefix_name      = local.prefix_name
  environment_name = local.environment_name

  user_pool_name                   = var.cognito_user_pool_name
  client_name                      = var.cognito_client_name
  callback_urls                    = var.cognito_callback_urls
  auto_verified_attributes         = var.cognito_auto_verified_attributes
  deletion_protection              = var.cognito_deletion_protection
  mfa_configuration                = var.cognito_mfa_configuration
  user_pool_tier                   = var.cognito_user_pool_tier
  username_attributes              = var.cognito_username_attributes
  allow_admin_create_user_only     = var.cognito_allow_admin_create_user_only
  password_minimum_length          = var.cognito_password_minimum_length
  password_history_size            = var.cognito_password_history_size
  password_require_lowercase       = var.cognito_password_require_lowercase
  password_require_numbers         = var.cognito_password_require_numbers
  password_require_symbols         = var.cognito_password_require_symbols
  password_require_uppercase       = var.cognito_password_require_uppercase
  temporary_password_validity_days = var.cognito_temporary_password_validity_days
  allowed_first_auth_factors       = var.cognito_allowed_first_auth_factors
  username_case_sensitive          = var.cognito_username_case_sensitive
  access_token_validity            = var.cognito_access_token_validity
  allowed_oauth_flows              = var.cognito_allowed_oauth_flows
  allowed_oauth_flows_user_pool_client = var.cognito_allowed_oauth_flows_user_pool_client
  allowed_oauth_scopes             = var.cognito_allowed_oauth_scopes
  auth_session_validity            = var.cognito_auth_session_validity
  explicit_auth_flows              = var.cognito_explicit_auth_flows
  id_token_validity                = var.cognito_id_token_validity
  logout_urls                      = var.cognito_logout_urls
  refresh_token_validity           = var.cognito_refresh_token_validity
  supported_identity_providers     = var.cognito_supported_identity_providers
  tags                             = var.cognito_tags
}


#========================================================================================#
#                                DYNAMODB MODULE                                        #
#========================================================================================#

module "dynamodb" {
  source = "./modules/dynamodb"

  video_slice_table_name       = var.dynamodb_video_slice_table_name
  idempotency_table_name       = var.dynamodb_idempotency_table_name
  notification_web_table_name  = var.dynamodb_notification_web_table_name
  deletion_protection_enabled  = var.dynamodb_deletion_protection_enabled
  stream_enabled               = var.dynamodb_stream_enabled
  point_in_time_recovery       = var.dynamodb_point_in_time_recovery
  tags                         = var.dynamodb_tags
}

#========================================================================================#
#                          API GATEWAY MODULE                                            #
#========================================================================================#

module "api_gateway" {
  source = "./modules/api-gateway"

  api_name                     = var.apigw_api_name
  authorizer_name              = var.apigw_authorizer_name
  cognito_user_pool_arn        = var.apigw_cognito_user_pool_arn
  stage_name                   = var.apigw_stage_name
  disable_execute_api_endpoint = var.apigw_disable_execute_api_endpoint
  tags                         = var.apigw_tags
}


#========================================================================================#
#                               EVENTBRIDGE MODULE                                      #
#========================================================================================#

module "eventbridge" {
  source = "./modules/eventbridge"

  event_bus_name            = var.eventbridge_bus_name
  event_bus_description     = var.eventbridge_bus_description
  enable_log_config         = var.eventbridge_enable_log_config
  redirect_role_name        = var.eventbridge_redirect_role_name
  redirect_role_description = var.eventbridge_redirect_role_description
  redirect_policy_name      = var.eventbridge_redirect_policy_name
  event_rule_name           = var.eventbridge_rule_name
  event_rule_description    = var.eventbridge_rule_description
  event_rule_state          = var.eventbridge_rule_state
  s3_bucket_name            = var.eventbridge_s3_bucket_name
  s3_object_prefix          = var.eventbridge_s3_object_prefix
  dlq_arn                   = var.eventbridge_dlq_arn
  pipe_name                 = var.eventbridge_pipe_name
  pipe_role_name            = var.eventbridge_pipe_role_name
  pipe_role_description     = var.eventbridge_pipe_role_description
  pipe_dynamodb_policy_name = var.eventbridge_pipe_dynamodb_policy_name
  pipe_events_policy_name   = var.eventbridge_pipe_events_policy_name
  pipe_sqs_policy_name      = var.eventbridge_pipe_sqs_policy_name
  pipe_desired_state        = var.eventbridge_pipe_desired_state
  dynamodb_stream_arn       = var.eventbridge_dynamodb_stream_arn
  pipe_dlq_arn              = var.eventbridge_pipe_dlq_arn
  pipe_log_group_arn        = var.eventbridge_pipe_log_group_arn
  tags                      = var.eventbridge_tags
}

#========================================================================================#
#                                 LAMBDA MODULE                                         #
#========================================================================================#

module "lambda" {
  source = "./modules/lambda"

  lambda_functions       = var.lambda_functions
  lambda_aliases         = var.lambda_aliases
  lambda_event_mappings  = var.lambda_event_mappings
  lambda_invoke_configs  = var.lambda_invoke_configs
  lambda_permissions     = var.lambda_permissions
  iam_roles              = var.lambda_iam_roles
  iam_policies           = var.lambda_iam_policies
  tags                   = var.lambda_tags
}

#========================================================================================#
#                                   SQS MODULE                                          #
#========================================================================================#

module "sqs" {
  source = "./modules/sqs"

  queues     = var.sqs_queues
  dlq_queues = var.sqs_dlq_queues
  tags       = var.sqs_tags
}

#========================================================================================#
#                                 APPSYNC MODULE                                        #
#========================================================================================#

module "appsync" {
  source = "./modules/appsync"

  api_name             = var.appsync_api_name
  authentication_type  = var.appsync_authentication_type
  introspection_config = var.appsync_introspection_config
  xray_enabled         = var.appsync_xray_enabled
  cognito_user_pool_id = var.appsync_cognito_user_pool_id
  cognito_aws_region   = var.appsync_cognito_aws_region
  tags                 = var.appsync_tags
}

#========================================================================================#
#                                 AMPLIFY MODULE                                        #
#========================================================================================#

module "amplify" {
  source = "./modules/amplify"

  app_name                  = var.amplify_app_name
  repository                = var.amplify_repository
  iam_service_role_arn      = var.amplify_iam_service_role_arn
  environment_variables     = var.amplify_environment_variables
  enable_branch_auto_build  = var.amplify_enable_branch_auto_build
  enable_basic_auth         = var.amplify_enable_basic_auth
  tags                      = var.amplify_tags
}

