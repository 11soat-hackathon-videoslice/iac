#========================================================================================#
#                            Configuration VARIABLES                                     #
#========================================================================================#

environment_name = "prd"
prefix_name = "vdsc"


#========================================================================================#
#                               COGNITO VARIABLES                                       #
#========================================================================================#

cognito_user_pool_name                       = "User pool - 4misf"
cognito_client_name                          = "vdsc-prd-cog-user-pool"
cognito_callback_urls                        = ["https://d84l1y8p4kdic.cloudfront.net"]
cognito_auto_verified_attributes             = ["email"]
cognito_deletion_protection                  = "ACTIVE"
cognito_mfa_configuration                    = "OFF"
cognito_user_pool_tier                       = "ESSENTIALS"
cognito_username_attributes                  = ["email"]
cognito_allow_admin_create_user_only         = false
cognito_password_minimum_length              = 8
cognito_password_history_size                = 0
cognito_password_require_lowercase           = true
cognito_password_require_numbers             = true
cognito_password_require_symbols             = true
cognito_password_require_uppercase           = true
cognito_temporary_password_validity_days     = 7
cognito_allowed_first_auth_factors           = ["PASSWORD"]
cognito_username_case_sensitive              = false
cognito_access_token_validity                = 60
cognito_allowed_oauth_flows                  = ["code"]
cognito_allowed_oauth_flows_user_pool_client = true
cognito_allowed_oauth_scopes                 = ["email", "openid", "phone"]
cognito_auth_session_validity                = 3
cognito_explicit_auth_flows                  = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_AUTH", "ALLOW_USER_SRP_AUTH"]
cognito_id_token_validity                    = 60
cognito_logout_urls                          = []
cognito_refresh_token_validity               = 5
cognito_supported_identity_providers         = ["COGNITO"]
cognito_tags                                 = {}


#========================================================================================#
#                               DYNAMODB VARIABLES                                      #
#========================================================================================#

dynamodb_video_slice_table_name      = "VideoSlice"
dynamodb_idempotency_table_name      = "VideoSliceIdempotencyTable"
dynamodb_notification_web_table_name = "VideoSliceNotificationWeb"
dynamodb_deletion_protection_enabled = false
dynamodb_stream_enabled              = true
dynamodb_point_in_time_recovery      = false
dynamodb_tags = {
  vdsc = ""
}


#========================================================================================#
#                                API GATEWAY  VARIABLES                                  #
#========================================================================================#

apigw_api_name                     = "vdsc-prd-api"
apigw_authorizer_name              = "vdsc-prd-api-authorizer"
apigw_cognito_user_pool_arn        = "arn:aws:cognito-idp:us-east-1:080145351546:userpool/us-east-1_D05wBn3u7"
apigw_stage_name                   = "prd"
apigw_disable_execute_api_endpoint = false
apigw_tags                         = {}


#========================================================================================#
#                               EVENTBRIDGE VARIABLES                                   #
#========================================================================================#

eventbridge_bus_name                  = "vdsc-prd-event-bus"
eventbridge_bus_description           = "Barramento de Eventos do Video Slice"
eventbridge_enable_log_config         = true
eventbridge_redirect_role_name        = "vdsc-prd-event-bus-redirect-role"
eventbridge_redirect_role_description = "Funcao para autorizar o servico do EventBrige Brige default se comunicar com EventiBrige customizado"
eventbridge_redirect_policy_name      = "vdsc-prd-eventBrige-redirect-custom-bus-policy"
eventbridge_rule_name                 = "vdsc-prd-event-rule-redirect-bus-vdsc"
eventbridge_rule_description          = "Regra de redirecionamento de evento de criação de arquivos no s3 vdsc-prd-s3-videos"
eventbridge_rule_state                = "DISABLED"
eventbridge_s3_bucket_name            = "vdsc-prd-s3-videos"
eventbridge_s3_object_prefix          = "uploads/"
eventbridge_dlq_arn                   = "arn:aws:sqs:us-east-1:080145351546:vdsc-prd-dlq"
eventbridge_tags = {
  vdsc = ""
}

eventbridge_pipe_name                 = "vdsc-prd-pipe-ddbstreams-to-vdsc-bus"
eventbridge_pipe_role_name            = "vdsc-prd-pipe-ddbstream-role"
eventbridge_pipe_role_description     = "Funcao para pipeline que coleta eventos do dynamodb streams"
eventbridge_pipe_dynamodb_policy_name = "vdsc-prd-pipe-ddbstreams-policy"
eventbridge_pipe_events_policy_name   = "vdsc-prd-pipe-events-policy"
eventbridge_pipe_sqs_policy_name      = "vdsc-prd-pipe-sqs-policy"
eventbridge_pipe_desired_state        = "RUNNING"
eventbridge_dynamodb_stream_arn       = "arn:aws:dynamodb:us-east-1:080145351546:table/VideoSlice/stream/2026-01-26T20:20:36.322"
eventbridge_pipe_dlq_arn              = "arn:aws:sqs:us-east-1:080145351546:vdsc-prd-sqs-pipe-ddb-dlq"
eventbridge_pipe_log_group_arn        = "arn:aws:logs:us-east-1:080145351546:log-group:/aws/vendedlogs/pipes/vdsc-prd-pipe-ddbstreams-to-vdsc-bus"


#========================================================================================#
#                                 LAMBDA VARIABLES                                       #
#========================================================================================#

lambda_functions = {
  video-slice = {
    function_name  = "vdsc-prd-lmb-video-slice"
    handler        = "app.lambda_handler"
    runtime        = "python3.12"
    memory_size    = 2048
    timeout        = 180
    ephemeral_size = 10240
    description    = "vdsc-prd-lmb-video-slice-config"
    role_arn       = "arn:aws:iam::080145351546:role/service-role/vdsc-prd-lmb-video-slice-role"
    environment    = {}
    zip_file       = "modules/lambda/source/aws_lambda_function__vdsc-prd-lmb-video-slice.zip"
  }
  notification-email = {
    function_name  = "vdsc-prd-lmb-notification-email"
    handler        = "lambda_function.lambda_handler"
    runtime        = "python3.12"
    memory_size    = 512
    timeout        = 30
    ephemeral_size = 512
    description    = "vdsc-prd-lmb-notification-email-config"
    role_arn       = "arn:aws:iam::080145351546:role/vdsc-prd-lmb-notification-email-role"
    environment    = {}
    zip_file       = "modules/lambda/source/aws_lambda_function__vdsc-prd-lmb-notification-email.zip"
  }
  notification-web = {
    function_name  = "vdsc-prd-lmb-notification-web"
    handler        = "app.lambda_handler"
    runtime        = "python3.12"
    memory_size    = 512
    timeout        = 5
    ephemeral_size = 512
    description    = "vdsc-prd-lmb-notification-web-config"
    role_arn       = "arn:aws:iam::080145351546:role/vdsc-prd-lmb-notification-web-role"
    environment    = {}
    zip_file       = "modules/lambda/source/aws_lambda_function__vdsc-prd-lmb-notification-web.zip"
  }
  url-generator = {
    function_name  = "vdsc-prd-lmb-video-url-generator"
    handler        = "app.lambda_handler"
    runtime        = "python3.12"
    memory_size    = 1769
    timeout        = 30
    ephemeral_size = 512
    description    = "vdsc-prd-lmb-video-url-generator-config"
    role_arn       = "arn:aws:iam::080145351546:role/service-role/vdsc-prd-lmb-url-generator-role"
    environment    = {}
    zip_file       = "modules/lambda/source/aws_lambda_function__vdsc-prd-lmb-video-url-generator.zip"
  }
}

lambda_aliases = {
  notification-email = {
    function_name    = "vdsc-prd-lmb-notification-email"
    alias_name       = "PRD"
    function_version = "$LATEST"
  }
  notification-web = {
    function_name    = "vdsc-prd-lmb-notification-web"
    alias_name       = "PRD"
    function_version = "$LATEST"
  }
  url-generator = {
    function_name    = "vdsc-prd-lmb-video-url-generator"
    alias_name       = "PRD"
    function_version = "$LATEST"
  }
}

lambda_event_mappings = {
  video-slice = {
    function_name    = "vdsc-prd-lmb-video-slice"
    event_source_arn = "arn:aws:sqs:us-east-1:080145351546:vdsc-prd-sqs-video-slice"
    batch_size       = 10
    enabled          = true
    response_types   = ["ReportBatchItemFailures"]
  }
  notification-email = {
    function_name    = "vdsc-prd-lmb-notification-email"
    event_source_arn = "arn:aws:sqs:us-east-1:080145351546:vdsc-prd-sqs-notification-email"
    batch_size       = 10
    enabled          = true
    response_types   = []
  }
  notification-web = {
    function_name    = "vdsc-prd-lmb-notification-web"
    event_source_arn = "arn:aws:sqs:us-east-1:080145351546:vdsc-prd-sqs-notification-web"
    batch_size       = 10
    enabled          = true
    response_types   = []
  }
}

lambda_invoke_configs = {
  video-slice = {
    function_name = "vdsc-prd-lmb-video-slice"
    dlq_arn       = "arn:aws:sqs:us-east-1:080145351546:vdsc-prd-sqs-video-slice-dlq"
  }
  notification-email = {
    function_name = "vdsc-prd-lmb-notification-email"
    dlq_arn       = "arn:aws:sqs:us-east-1:080145351546:vdsc-prd-sqs-notification-email-dlq"
  }
  notification-web = {
    function_name = "vdsc-prd-lmb-notification-web"
    dlq_arn       = "arn:aws:sqs:us-east-1:080145351546:vdsc-prd-sqs-notification-web-dlq"
  }
}

lambda_permissions = {
  url-generator = {
    function_name = "vdsc-prd-lmb-video-url-generator"
    statement_id  = "1c234908-c848-584a-8698-2e925d6077e6"
    principal     = "apigateway.amazonaws.com"
    source_arn    = "arn:aws:execute-api:us-east-1:080145351546:fj8aqi31jh/*/POST/video/download/url/*"
  }
}

lambda_iam_roles = {
  video-slice = {
    role_name   = "vdsc-prd-lmb-video-slice-role"
    description = ""
    path        = "/service-role/"
    inline_policies = {
      ddb-policy       = "video-slice-ddb-policy.json"
      events-policy    = "video-slice-events-policy.json"
      s3-policy        = "video-slice-s3-policy.json"
      scheduler-policy = "video-slice-scheduler-policy.json"
    }
    managed_policies = [
      "arn:aws:iam::080145351546:policy/service-role/AWSLambdaBasicExecutionRole-b49c0c59-3a3d-401f-80d5-9dbe0377dcb8",
      "arn:aws:iam::080145351546:policy/service-role/AWSLambdaDurableExecutionRole-fba3203d-09ea-494b-9589-513ea9608b90",
      "arn:aws:iam::080145351546:policy/vdsc-prd-lmd-sqs-policy"
    ]
  }
  notification-email = {
    role_name   = "vdsc-prd-lmb-notification-email-role"
    description = "vdsc-prd-lmb-notification-email-role"
    path        = "/"
    inline_policies = {
      cgn-policy = "notification-email-cgn-policy.json"
      ses-policy = "notification-email-ses-policy.json"
      sqs-policy = "notification-email-sqs-policy.json"
    }
    managed_policies = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  }
  notification-web = {
    role_name   = "vdsc-prd-lmb-notification-web-role"
    description = "vdsc-prd-lmb-notification-web-role"
    path        = "/"
    inline_policies = {
      appsync-policy = "notification-web-appsync-policy.json"
      sqs-policy     = "notification-web-sqs-policy.json"
    }
    managed_policies = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  }
  url-generator = {
    role_name   = "vdsc-prd-lmb-url-generator-role"
    description = ""
    path        = "/service-role/"
    inline_policies = {
      s3-policy = "url-generator-s3-policy.json"
    }
    managed_policies = [
      "arn:aws:iam::080145351546:policy/service-role/AWSLambdaBasicExecutionRole-a7e1df6a-d953-450e-bde9-b4f1d5b7b5a1",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    ]
  }
}

lambda_iam_policies = {
  basic-exec-a7e1df6a = {
    policy_name = "AWSLambdaBasicExecutionRole-a7e1df6a-d953-450e-bde9-b4f1d5b7b5a1"
    path        = "/service-role/"
    description = ""
    policy_file = "basic-exec-a7e1df6a.json"
  }
  basic-exec-b49c0c59 = {
    policy_name = "AWSLambdaBasicExecutionRole-b49c0c59-3a3d-401f-80d5-9dbe0377dcb8"
    path        = "/service-role/"
    description = ""
    policy_file = "basic-exec-b49c0c59.json"
  }
  durable-exec = {
    policy_name = "AWSLambdaDurableExecutionRole-fba3203d-09ea-494b-9589-513ea9608b90"
    path        = "/service-role/"
    description = ""
    policy_file = "durable-exec.json"
  }
  sqs-policy = {
    policy_name = "vdsc-prd-lmd-sqs-policy"
    path        = "/"
    description = "Politica de leitura de mensagens pelo servico lambda"
    policy_file = "sqs-policy.json"
  }
}

lambda_tags = {
  vdsc = ""
}


#========================================================================================#
#                                   SQS VARIABLES                                        #
#========================================================================================#

sqs_dlq_queues = {
  video-slice-dlq = {
    name                       = "vdsc-prd-sqs-video-slice-dlq"
    visibility_timeout_seconds = 30
    eventbridge_rule_arn       = "arn:aws:events:us-east-1:080145351546:rule/vdsc-prd-event-bus/vdsc-prd-event-bus-rule-upload-video-slice"
  }
  notification-email-dlq = {
    name                       = "vdsc-prd-sqs-notification-email-dlq"
    visibility_timeout_seconds = 30
    eventbridge_rule_arn       = "arn:aws:events:us-east-1:080145351546:rule/vdsc-prd-event-bus/vdsc-prd-event-bus-rule-upload-video-slice"
  }
  notification-web-dlq = {
    name                       = "vdsc-prd-sqs-notification-web-dlq"
    visibility_timeout_seconds = 30
    eventbridge_rule_arn       = "arn:aws:events:us-east-1:080145351546:rule/vdsc-prd-event-bus/vdsc-prd-event-bus-rule-upload-video-slice"
  }
  pipe-ddb-dlq = {
    name                       = "vdsc-prd-sqs-pipe-ddb-dlq"
    visibility_timeout_seconds = 30
    eventbridge_rule_arn       = "arn:aws:events:us-east-1:080145351546:rule/vdsc-prd-event-bus/vdsc-prd-event-bus-rule-upload-video-slice"
  }
  dlq = {
    name                       = "vdsc-prd-dlq"
    visibility_timeout_seconds = 30
    eventbridge_rule_arn       = "arn:aws:events:us-east-1:080145351546:rule/vdsc-prd-event-rule-redirect-bus-vdsc"
  }
}

sqs_queues = {
  video-slice = {
    name                       = "vdsc-prd-sqs-video-slice"
    delay_seconds              = 0
    max_message_size           = 1048576
    message_retention_seconds  = 345600
    receive_wait_time_seconds  = 0
    visibility_timeout_seconds = 180
    dlq_arn                    = "arn:aws:sqs:us-east-1:080145351546:vdsc-prd-sqs-video-slice-dlq"
    max_receive_count          = 1000
  }
  notification-email = {
    name                       = "vdsc-prd-sqs-notification-email"
    delay_seconds              = 0
    max_message_size           = 1048576
    message_retention_seconds  = 345600
    receive_wait_time_seconds  = 0
    visibility_timeout_seconds = 30
    dlq_arn                    = "arn:aws:sqs:us-east-1:080145351546:vdsc-prd-sqs-notification-email-dlq"
    max_receive_count          = 1000
  }
  notification-web = {
    name                       = "vdsc-prd-sqs-notification-web"
    delay_seconds              = 0
    max_message_size           = 1048576
    message_retention_seconds  = 345600
    receive_wait_time_seconds  = 0
    visibility_timeout_seconds = 5
    dlq_arn                    = "arn:aws:sqs:us-east-1:080145351546:vdsc-prd-sqs-notification-web-dlq"
    max_receive_count          = 1000
  }
}

sqs_tags = {
  vdsc = ""
}


#========================================================================================#
#                               APPSYNC VARIABLES                                       #
#========================================================================================#

appsync_api_name             = "vdsc-prd-notification-web-appsync"
appsync_authentication_type  = "API_KEY"
appsync_introspection_config = "ENABLED"
appsync_xray_enabled         = false
appsync_cognito_user_pool_id = "us-east-1_D05wBn3u7"
appsync_cognito_aws_region   = "us-east-1"
appsync_tags = {
  vdsc = ""
}


#========================================================================================#
#                               AMPLIFY VARIABLES                                       #
#========================================================================================#

amplify_app_name                  = "vdsc-prd-web-app"
amplify_repository                = "https://github.com/11soat-hackathon-videoslice/fe-video-slice"
amplify_iam_service_role_arn      = "arn:aws:iam::080145351546:role/vdsc-prd-amplify-web-app-role"
amplify_enable_branch_auto_build  = false
amplify_enable_basic_auth         = false
amplify_environment_variables = {}
amplify_tags = {}
