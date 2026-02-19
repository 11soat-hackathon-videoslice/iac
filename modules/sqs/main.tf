data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# DLQ Queues
resource "aws_sqs_queue" "dlq" {
  for_each = var.dlq_queues

  name                       = each.value.name
  visibility_timeout_seconds = each.value.visibility_timeout_seconds
  sqs_managed_sse_enabled    = true
  tags                       = var.tags

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "__owner_statement"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "SQS:*"
        Resource = "arn:aws:sqs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:${each.value.name}"
      },
      {
        Sid    = "AllowEventBridge"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = "arn:aws:sqs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:${each.value.name}"
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = each.value.eventbridge_rule_arn
          }
        }
      }
    ]
  })
}

# Main Queues
resource "aws_sqs_queue" "main" {
  for_each = var.queues

  name                       = each.value.name
  delay_seconds              = each.value.delay_seconds
  max_message_size           = each.value.max_message_size
  message_retention_seconds  = each.value.message_retention_seconds
  receive_wait_time_seconds  = each.value.receive_wait_time_seconds
  visibility_timeout_seconds = each.value.visibility_timeout_seconds
  sqs_managed_sse_enabled    = true
  tags                       = var.tags

  redrive_policy = jsonencode({
    deadLetterTargetArn = each.value.dlq_arn
    maxReceiveCount     = each.value.max_receive_count
  })

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "__owner_statement"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      }
      Action   = "SQS:*"
      Resource = "arn:aws:sqs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:${each.value.name}"
    }]
  })

  depends_on = [aws_sqs_queue.dlq]
}
