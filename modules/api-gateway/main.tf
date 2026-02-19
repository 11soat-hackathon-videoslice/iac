data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# REST API
resource "aws_api_gateway_rest_api" "this" {
  name                         = var.api_name
  disable_execute_api_endpoint = var.disable_execute_api_endpoint
  tags                         = var.tags

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# Authorizer
resource "aws_api_gateway_authorizer" "this" {
  name                             = var.authorizer_name
  rest_api_id                      = aws_api_gateway_rest_api.this.id
  type                             = "COGNITO_USER_POOLS"
  provider_arns                    = [var.cognito_user_pool_arn]
  identity_source                  = "method.request.header.Authorization"
  authorizer_result_ttl_in_seconds = 300
}

# Resources
resource "aws_api_gateway_resource" "root_proxy" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_resource" "video" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "video"
}

resource "aws_api_gateway_resource" "video_upload" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.video.id
  path_part   = "upload"
}

resource "aws_api_gateway_resource" "video_upload_url" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.video_upload.id
  path_part   = "url"
}

resource "aws_api_gateway_resource" "video_upload_url_filename" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.video_upload_url.id
  path_part   = "{fileName}"
}

resource "aws_api_gateway_resource" "video_list" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.video.id
  path_part   = "list"
}

resource "aws_api_gateway_resource" "video_list_user" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.video_list.id
  path_part   = "user"
}

resource "aws_api_gateway_resource" "video_list_user_id" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.video_list_user.id
  path_part   = "{userId}"
}

resource "aws_api_gateway_resource" "video_process" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.video.id
  path_part   = "process"
}

resource "aws_api_gateway_resource" "video_process_id" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.video_process.id
  path_part   = "{videoId}"
}

resource "aws_api_gateway_resource" "video_notification" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.video.id
  path_part   = "notification"
}

resource "aws_api_gateway_resource" "video_notification_id" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.video_notification.id
  path_part   = "{userId}"
}

# Methods
resource "aws_api_gateway_method" "upload_url_post" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.video_upload_url_filename.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.this.id
  request_parameters = {
    "method.request.path.fileName" = true
  }
}

resource "aws_api_gateway_method" "process_post" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.video_process_id.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.this.id
}

resource "aws_api_gateway_method" "upload_post" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.video_upload.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.this.id
}

resource "aws_api_gateway_method" "list_user_get" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.video_list_user_id.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.this.id
}

# Deployment
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  depends_on = [
    aws_api_gateway_method.upload_url_post,
    aws_api_gateway_method.process_post,
    aws_api_gateway_method.upload_post,
    aws_api_gateway_method.list_user_get
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# Stage
resource "aws_api_gateway_stage" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
  stage_name    = var.stage_name
  tags          = var.tags
}
