data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# Event Bus
resource "aws_cloudwatch_event_bus" "this" {
  name        = var.event_bus_name
  description = var.event_bus_description
  tags        = var.tags

  dynamic "log_config" {
    for_each = var.enable_log_config ? [1] : []
    content {
      include_detail = "NONE"
      level          = "TRACE"
    }
  }
}

# IAM Role for EventBridge
resource "aws_iam_role" "redirect" {
  name        = var.redirect_role_name
  description = var.redirect_role_description

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "TrustEventBridgeService"
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action = "sts:AssumeRole"
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          "aws:SourceArn"     = "arn:aws:events:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:rule/${var.event_rule_name}"
        }
      }
    }]
  })

  tags = var.tags
}

# IAM Role Policy
resource "aws_iam_role_policy" "redirect" {
  name = var.redirect_policy_name
  role = aws_iam_role.redirect.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid      = "ActionsForResource"
      Effect   = "Allow"
      Action   = ["events:PutEvents"]
      Resource = [aws_cloudwatch_event_bus.this.arn]
    }]
  })
}

# Event Rule
resource "aws_cloudwatch_event_rule" "redirect" {
  name           = var.event_rule_name
  description    = var.event_rule_description
  event_bus_name = "default"
  state          = var.event_rule_state

  event_pattern = jsonencode({
    source      = ["aws.s3"]
    detail-type = ["Object Created"]
    detail = {
      bucket = {
        name = [var.s3_bucket_name]
      }
      object = {
        key = [{
          prefix = var.s3_object_prefix
        }]
      }
    }
  })

  tags = var.tags
}

# Event Target
resource "aws_cloudwatch_event_target" "redirect" {
  rule           = aws_cloudwatch_event_rule.redirect.name
  event_bus_name = "default"
  arn            = aws_cloudwatch_event_bus.this.arn
  role_arn       = aws_iam_role.redirect.arn

  dead_letter_config {
    arn = var.dlq_arn
  }
}


# IAM Role for Pipes
resource "aws_iam_role" "pipe" {
  name        = var.pipe_role_name
  description = var.pipe_role_description

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "pipes.amazonaws.com"
      }
      Action = "sts:AssumeRole"
      Condition = {
        StringEquals = {
          "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          "aws:SourceArn"     = "arn:aws:pipes:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:pipe/${var.pipe_name}"
        }
      }
    }]
  })

  tags = var.tags
}

# IAM Policy for DynamoDB Streams
resource "aws_iam_role_policy" "pipe_dynamodb" {
  name = var.pipe_dynamodb_policy_name
  role = aws_iam_role.pipe.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "dynamodb:DescribeStream",
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator",
        "dynamodb:ListStreams"
      ]
      Resource = [var.dynamodb_stream_arn]
    }]
  })
}

# IAM Policy for EventBridge
resource "aws_iam_role_policy" "pipe_events" {
  name = var.pipe_events_policy_name
  role = aws_iam_role.pipe.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["events:PutEvents"]
      Resource = [aws_cloudwatch_event_bus.this.arn]
    }]
  })
}

# IAM Policy for SQS DLQ
resource "aws_iam_role_policy" "pipe_sqs" {
  name = var.pipe_sqs_policy_name
  role = aws_iam_role.pipe.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["sqs:SendMessage"]
      Resource = [var.pipe_dlq_arn]
    }]
  })
}

# EventBridge Pipe
resource "aws_pipes_pipe" "this" {
  name          = var.pipe_name
  role_arn      = aws_iam_role.pipe.arn
  source        = var.dynamodb_stream_arn
  target        = aws_cloudwatch_event_bus.this.arn
  desired_state = var.pipe_desired_state
  tags          = var.tags

  log_configuration {
    level = "INFO"
    cloudwatch_logs_log_destination {
      log_group_arn = var.pipe_log_group_arn
    }
  }

  source_parameters {
    dynamodb_stream_parameters {
      starting_position                  = "LATEST"
      batch_size                         = 10
      maximum_batching_window_in_seconds = 0
      maximum_record_age_in_seconds      = -1
      maximum_retry_attempts             = 5

      dead_letter_config {
        arn = var.pipe_dlq_arn
      }
    }

    filter_criteria {
      filter {
        pattern = jsonencode({
          eventName = ["INSERT"]
          dynamodb = {
            NewImage = {
              status = {
                S = ["UPLOADED"]
              }
            }
          }
        })
      }
    }
  }

  target_parameters {
    eventbridge_event_bus_parameters {
      source = "vdsc.pipe"
    }
  }

  lifecycle {
    ignore_changes = [description]
  }
}
