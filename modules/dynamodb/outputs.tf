output "video_slice_table_name" {
  value       = aws_dynamodb_table.video_slice.name
  description = "VideoSlice table name"
}

output "video_slice_table_arn" {
  value       = aws_dynamodb_table.video_slice.arn
  description = "VideoSlice table ARN"
}

output "video_slice_stream_arn" {
  value       = aws_dynamodb_table.video_slice.stream_arn
  description = "VideoSlice stream ARN"
}

output "idempotency_table_name" {
  value       = aws_dynamodb_table.idempotency.name
  description = "Idempotency table name"
}

output "idempotency_table_arn" {
  value       = aws_dynamodb_table.idempotency.arn
  description = "Idempotency table ARN"
}

output "notification_web_table_name" {
  value       = aws_dynamodb_table.notification_web.name
  description = "NotificationWeb table name"
}

output "notification_web_table_arn" {
  value       = aws_dynamodb_table.notification_web.arn
  description = "NotificationWeb table ARN"
}
