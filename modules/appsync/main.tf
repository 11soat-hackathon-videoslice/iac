resource "aws_appsync_graphql_api" "this" {
  name                 = var.api_name
  authentication_type  = var.authentication_type
  introspection_config = var.introspection_config
  xray_enabled         = var.xray_enabled
  tags                 = var.tags

  additional_authentication_provider {
    authentication_type = "AWS_IAM"
  }

  additional_authentication_provider {
    authentication_type = "AMAZON_COGNITO_USER_POOLS"

    user_pool_config {
      aws_region   = var.cognito_aws_region
      user_pool_id = var.cognito_user_pool_id
    }
  }
}
