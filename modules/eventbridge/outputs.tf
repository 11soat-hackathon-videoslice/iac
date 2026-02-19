output "event_bus_name" {
  value       = aws_cloudwatch_event_bus.this.name
  description = "EventBridge event bus name"
}

output "event_bus_arn" {
  value       = aws_cloudwatch_event_bus.this.arn
  description = "EventBridge event bus ARN"
}

output "event_rule_name" {
  value       = aws_cloudwatch_event_rule.redirect.name
  description = "EventBridge rule name"
}

output "event_rule_arn" {
  value       = aws_cloudwatch_event_rule.redirect.arn
  description = "EventBridge rule ARN"
}

output "iam_role_arn" {
  value       = aws_iam_role.redirect.arn
  description = "IAM role ARN for event redirection"
}

output "iam_role_name" {
  value       = aws_iam_role.redirect.name
  description = "IAM role name for event redirection"
}


output "pipe_name" {
  value       = aws_pipes_pipe.this.name
  description = "EventBridge Pipe name"
}

output "pipe_arn" {
  value       = aws_pipes_pipe.this.arn
  description = "EventBridge Pipe ARN"
}

output "pipe_role_arn" {
  value       = aws_iam_role.pipe.arn
  description = "Pipes IAM role ARN"
}
