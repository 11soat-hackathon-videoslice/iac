data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# Data sources for inline policies
data "local_file" "inline_policies" {
  for_each = fileset("${path.module}/policies", "*.json")
  filename = "${path.module}/policies/${each.value}"
}

# Data sources for managed policies
data "local_file" "managed_policies" {
  for_each = fileset("${path.module}/policies", "*.json")
  filename = "${path.module}/policies/${each.value}"
}

# IAM Policies
resource "aws_iam_policy" "this" {
  for_each = var.iam_policies

  name        = each.value.policy_name
  path        = each.value.path
  description = each.value.description
  policy      = data.local_file.managed_policies[each.value.policy_file].content
  tags        = var.tags
}

# IAM Roles
resource "aws_iam_role" "this" {
  for_each = var.iam_roles

  name        = each.value.role_name
  description = each.value.description
  path        = each.value.path
  tags        = var.tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# IAM Role Inline Policies
resource "aws_iam_role_policy" "this" {
  for_each = merge([
    for role_key, role in var.iam_roles : {
      for policy_key, policy_file in role.inline_policies :
      "${role_key}_${policy_key}" => {
        role_name   = role.role_name
        policy_name = policy_key
        policy      = data.local_file.inline_policies[policy_file].content
      }
    }
  ]...)

  name   = each.value.policy_name
  role   = aws_iam_role.this[split("_", each.key)[0]].id
  policy = each.value.policy
}

# IAM Role Policy Attachments
resource "aws_iam_role_policy_attachment" "managed" {
  for_each = merge([
    for role_key, role in var.iam_roles : {
      for idx, policy_arn in role.managed_policies :
      "${role_key}_${idx}" => {
        role_name  = role.role_name
        policy_arn = policy_arn
      }
    }
  ]...)

  role       = aws_iam_role.this[split("_", each.key)[0]].name
  policy_arn = each.value.policy_arn
}

# IAM Role Policy Attachments for custom policies
resource "aws_iam_role_policy_attachment" "custom" {
  for_each = {
    for key, policy in var.iam_policies :
    key => policy
    if contains(keys(var.iam_roles), key)
  }

  role       = aws_iam_role.this[each.key].name
  policy_arn = aws_iam_policy.this[each.key].arn
}

# Lambda Functions
resource "aws_lambda_function" "this" {
  for_each = var.lambda_functions

  function_name = each.value.function_name
  handler       = each.value.handler
  runtime       = each.value.runtime
  memory_size   = each.value.memory_size
  timeout       = each.value.timeout
  description   = each.value.description
  role          = each.value.role_arn
  filename      = each.value.zip_file
  source_code_hash = filebase64sha256(each.value.zip_file)
  tags          = var.tags

  environment {
    variables = each.value.environment
  }

  ephemeral_storage {
    size = each.value.ephemeral_size
  }

  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/${each.value.function_name}"
  }

  tracing_config {
    mode = "PassThrough"
  }

  lifecycle {
    ignore_changes = [filename, publish, source_code_hash]
  }
}

# Lambda Aliases
resource "aws_lambda_alias" "this" {
  for_each = var.lambda_aliases

  name             = each.value.alias_name
  function_name    = each.value.function_name
  function_version = each.value.function_version

  depends_on = [aws_lambda_function.this]
}

# Lambda Event Source Mappings
resource "aws_lambda_event_source_mapping" "this" {
  for_each = var.lambda_event_mappings

  function_name     = each.value.function_name
  event_source_arn  = each.value.event_source_arn
  batch_size        = each.value.batch_size
  enabled           = each.value.enabled
  function_response_types = each.value.response_types
  tags              = var.tags

  depends_on = [aws_lambda_function.this]
}

# Lambda Function Event Invoke Configs
resource "aws_lambda_function_event_invoke_config" "this" {
  for_each = var.lambda_invoke_configs

  function_name = each.value.function_name
  qualifier     = "$LATEST"

  destination_config {
    on_failure {
      destination = each.value.dlq_arn
    }
  }

  maximum_retry_attempts    = 0
  maximum_event_age_in_seconds = 60

  depends_on = [aws_lambda_function.this]
}

# Lambda Permissions
resource "aws_lambda_permission" "this" {
  for_each = var.lambda_permissions

  statement_id  = each.value.statement_id
  action        = "lambda:InvokeFunction"
  function_name = each.value.function_name
  principal     = each.value.principal
  source_arn    = each.value.source_arn

  depends_on = [aws_lambda_function.this]
}
