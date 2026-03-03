resource "aws_appsync_graphql_api" "this" {
  name                 = var.api_name
  authentication_type  = var.authentication_type
  introspection_config = var.introspection_config
  xray_enabled         = var.xray_enabled
  tags                 = var.tags
  schema               = file("${path.module}/schema/schema.graphql")

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

resource "aws_appsync_datasource" "dynamodb" {
  api_id           = aws_appsync_graphql_api.this.id
  name             = "NotificationDataSource"
  service_role_arn = var.appsync_service_role_arn
  type             = "AMAZON_DYNAMODB"

  dynamodb_config {
    table_name = var.dynamodb_table_name
  }
}

resource "aws_appsync_resolver" "create_notification" {
  api_id      = aws_appsync_graphql_api.this.id
  field       = "createNotification"
  type        = "Mutation"
  data_source = aws_appsync_datasource.dynamodb.name
  runtime {
    name            = "APPSYNC_JS"
    runtime_version = "1.0.0"
  }
  code = file("${path.module}/resolvers/Mutation.createNotification.js")
}

resource "aws_appsync_resolver" "mark_as_read" {
  api_id      = aws_appsync_graphql_api.this.id
  field       = "markAsRead"
  type        = "Mutation"
  data_source = aws_appsync_datasource.dynamodb.name
  runtime {
    name            = "APPSYNC_JS"
    runtime_version = "1.0.0"
  }
  code = file("${path.module}/resolvers/Mutation.markAsRead.js")
}

resource "aws_appsync_resolver" "get_notifications_by_user" {
  api_id      = aws_appsync_graphql_api.this.id
  field       = "getNotificationsByUser"
  type        = "Query"
  data_source = aws_appsync_datasource.dynamodb.name
  runtime {
    name            = "APPSYNC_JS"
    runtime_version = "1.0.0"
  }
  code = file("${path.module}/resolvers/Query.getNotificationsByUser.js")
}
