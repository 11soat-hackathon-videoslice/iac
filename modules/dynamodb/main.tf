data "aws_region" "current" {}

resource "aws_dynamodb_table" "video_slice" {
  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = var.deletion_protection_enabled
  hash_key                    = "videoId"
  name                        = var.video_slice_table_name
  stream_enabled              = var.stream_enabled
  stream_view_type            = var.stream_enabled ? "NEW_AND_OLD_IMAGES" : null
  table_class                 = "STANDARD"
  tags                        = var.tags
  tags_all                    = var.tags

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "videoId"
    type = "S"
  }

  global_secondary_index {
    hash_key           = "userId"
    name               = "userId"
    non_key_attributes = []
    projection_type    = "ALL"
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "idempotency" {
  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = var.deletion_protection_enabled
  hash_key                    = "id"
  name                        = var.idempotency_table_name
  table_class                 = "STANDARD"
  tags                        = var.tags
  tags_all                    = var.tags

  attribute {
    name = "id"
    type = "S"
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  ttl {
    enabled = false
  }
}

resource "aws_dynamodb_table" "notification_web" {
  billing_mode                = "PAY_PER_REQUEST"
  deletion_protection_enabled = var.deletion_protection_enabled
  hash_key                    = "id"
  range_key                   = "timestamp"
  name                        = var.notification_web_table_name
  table_class                 = "STANDARD"
  tags                        = var.tags
  tags_all                    = var.tags

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  attribute {
    name = "userId"
    type = "S"
  }

  global_secondary_index {
    hash_key           = "userId"
    name               = "userId"
    non_key_attributes = []
    projection_type    = "ALL"
    range_key          = "timestamp"
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  ttl {
    enabled = false
  }
}
