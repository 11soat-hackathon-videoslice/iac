variable "video_slice_table_name" {
  type        = string
  description = "Name of the VideoSlice DynamoDB table"
}

variable "idempotency_table_name" {
  type        = string
  description = "Name of the Idempotency DynamoDB table"
}

variable "notification_web_table_name" {
  type        = string
  description = "Name of the NotificationWeb DynamoDB table"
}

variable "deletion_protection_enabled" {
  type        = bool
  description = "Enable deletion protection for DynamoDB tables"
  default     = false
}

variable "stream_enabled" {
  type        = bool
  description = "Enable DynamoDB streams"
  default     = true
}

variable "point_in_time_recovery" {
  type        = bool
  description = "Enable point-in-time recovery"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to DynamoDB tables"
  default     = {}
}
