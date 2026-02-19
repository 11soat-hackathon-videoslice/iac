variable "queues" {
  type = map(object({
    name                       = string
    delay_seconds              = number
    max_message_size           = number
    message_retention_seconds  = number
    receive_wait_time_seconds  = number
    visibility_timeout_seconds = number
    dlq_arn                    = string
    max_receive_count          = number
  }))
}

variable "dlq_queues" {
  type = map(object({
    name                       = string
    visibility_timeout_seconds = number
    eventbridge_rule_arn       = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
