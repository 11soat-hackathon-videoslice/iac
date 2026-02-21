locals {
  prefix_name      = var.prefix_name
  environment_name = var.environment_name
  region           = "us-east-1"

  lambda_functions_with_env = {
    for key, func in var.lambda_functions : key => merge(func, {
      environment = key == "notification-web" ? merge(func.environment, {
        APPSYNC_URL          = var.lambda_notification_web_appsync_url != "" ? var.lambda_notification_web_appsync_url : lookup(func.environment, "APPSYNC_URL", "")
        AWS_LAMBDA_LOG_LEVEL = var.lambda_notification_web_log_level != "" ? var.lambda_notification_web_log_level : lookup(func.environment, "AWS_LAMBDA_LOG_LEVEL", "")
      }) : key == "video-slice" ? merge(func.environment, {
        AWS_REGION                          = var.lambda_video_slice_aws_region != "" ? var.lambda_video_slice_aws_region : lookup(func.environment, "AWS_REGION", "")
        S3_BUCKET_NAME                      = var.lambda_video_slice_s3_bucket_name != "" ? var.lambda_video_slice_s3_bucket_name : lookup(func.environment, "S3_BUCKET_NAME", "")
        EVENT_BUS_NAME                      = var.lambda_video_slice_event_bus_name != "" ? var.lambda_video_slice_event_bus_name : lookup(func.environment, "EVENT_BUS_NAME", "")
        DYNAMODB_TABLE_NAME                 = var.lambda_video_slice_dynamodb_table_name != "" ? var.lambda_video_slice_dynamodb_table_name : lookup(func.environment, "DYNAMODB_TABLE_NAME", "")
        VDSC_DIR_UPLOADS                    = var.lambda_video_slice_dir_uploads != "" ? var.lambda_video_slice_dir_uploads : lookup(func.environment, "VDSC_DIR_UPLOADS", "")
        VDSC_DIR_FINISHED                   = var.lambda_video_slice_dir_finished != "" ? var.lambda_video_slice_dir_finished : lookup(func.environment, "VDSC_DIR_FINISHED", "")
        VDSC_DIR_TMP                        = var.lambda_video_slice_dir_tmp != "" ? var.lambda_video_slice_dir_tmp : lookup(func.environment, "VDSC_DIR_TMP", "")
        VDSC_MAX_WORKERS                    = var.lambda_video_slice_max_workers != "" ? var.lambda_video_slice_max_workers : lookup(func.environment, "VDSC_MAX_WORKERS", "")
        SCHEDULE_EVENT_RETRY_BACKOFF_FACTOR = var.lambda_video_slice_retry_backoff_factor != "" ? var.lambda_video_slice_retry_backoff_factor : lookup(func.environment, "SCHEDULE_EVENT_RETRY_BACKOFF_FACTOR", "")
        SCHEDULE_EVENT_ROLE_ARN             = var.lambda_video_slice_role_arn != "" ? var.lambda_video_slice_role_arn : lookup(func.environment, "SCHEDULE_EVENT_ROLE_ARN", "")
        SCHEDULE_EVENT_DLQ                  = var.lambda_video_slice_dlq != "" ? var.lambda_video_slice_dlq : lookup(func.environment, "SCHEDULE_EVENT_DLQ", "")
        AWS_LAMBDA_LOG_LEVEL                = var.lambda_video_slice_log_level != "" ? var.lambda_video_slice_log_level : lookup(func.environment, "AWS_LAMBDA_LOG_LEVEL", "")
        POWERTOOLS_SERVICE_NAME             = var.lambda_video_slice_powertools_service_name != "" ? var.lambda_video_slice_powertools_service_name : lookup(func.environment, "POWERTOOLS_SERVICE_NAME", "")
        POWERTOOLS_METRICS_NAMESPACE        = var.lambda_video_slice_powertools_metrics_namespace != "" ? var.lambda_video_slice_powertools_metrics_namespace : lookup(func.environment, "POWERTOOLS_METRICS_NAMESPACE", "")
      }) : key == "notification-email" ? merge(func.environment, {
        AWS_COGNITO_USER_POOL           = var.lambda_notification_email_cognito_user_pool != "" ? var.lambda_notification_email_cognito_user_pool : lookup(func.environment, "AWS_COGNITO_USER_POOL", "")
        AWS_REGION                      = var.lambda_notification_email_aws_region != "" ? var.lambda_notification_email_aws_region : lookup(func.environment, "AWS_REGION", "")
        NOTIFICATION_EMAIL_FROM_EMAIL   = var.lambda_notification_email_from_email != "" ? var.lambda_notification_email_from_email : lookup(func.environment, "NOTIFICATION_EMAIL_FROM_EMAIL", "")
        NOTIFICATION_EMAIL_LOGO_URL     = var.lambda_notification_email_logo_url != "" ? var.lambda_notification_email_logo_url : lookup(func.environment, "NOTIFICATION_EMAIL_LOGO_URL", "")
        NOTIFICATION_EMAIL_DASHBOARD_URL = var.lambda_notification_email_dashboard_url != "" ? var.lambda_notification_email_dashboard_url : lookup(func.environment, "NOTIFICATION_EMAIL_DASHBOARD_URL", "")
        NOTIFICATION_EMAIL_TIMEZONE     = var.lambda_notification_email_timezone != "" ? var.lambda_notification_email_timezone : lookup(func.environment, "NOTIFICATION_EMAIL_TIMEZONE", "")
        NOTIFICATION_EMAIL_TEMPLATE     = var.lambda_notification_email_template != "" ? var.lambda_notification_email_template : lookup(func.environment, "NOTIFICATION_EMAIL_TEMPLATE", "")
      }) : key == "url-generator" ? merge(func.environment, {
        AWS_REGION                   = var.lambda_url_generator_aws_region != "" ? var.lambda_url_generator_aws_region : lookup(func.environment, "AWS_REGION", "")
        S3_SIGNATURE_VERSION         = var.lambda_url_generator_s3_signature_version != "" ? var.lambda_url_generator_s3_signature_version : lookup(func.environment, "S3_SIGNATURE_VERSION", "")
        S3_BUCKET_NAME               = var.lambda_url_generator_s3_bucket_name != "" ? var.lambda_url_generator_s3_bucket_name : lookup(func.environment, "S3_BUCKET_NAME", "")
        S3_URL_DOWNLOAD_EXPIRATION   = var.lambda_url_generator_s3_url_download_expiration != "" ? var.lambda_url_generator_s3_url_download_expiration : lookup(func.environment, "S3_URL_DOWNLOAD_EXPIRATION", "")
        S3_URL_UPLOAD_EXPIRATION     = var.lambda_url_generator_s3_url_upload_expiration != "" ? var.lambda_url_generator_s3_url_upload_expiration : lookup(func.environment, "S3_URL_UPLOAD_EXPIRATION", "")
        S3_BUCKET_DIR_UPLOADS        = var.lambda_url_generator_s3_bucket_dir_uploads != "" ? var.lambda_url_generator_s3_bucket_dir_uploads : lookup(func.environment, "S3_BUCKET_DIR_UPLOADS", "")
        S3_BUCKET_DIR_FINISHED       = var.lambda_url_generator_s3_bucket_dir_finished != "" ? var.lambda_url_generator_s3_bucket_dir_finished : lookup(func.environment, "S3_BUCKET_DIR_FINISHED", "")
      }) : func.environment
    })
  }
}

