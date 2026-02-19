data "aws_region" "current" {}

resource "aws_cognito_user_pool" "this" {
  alias_attributes         = null
  auto_verified_attributes = var.auto_verified_attributes
  deletion_protection      = var.deletion_protection
  mfa_configuration        = var.mfa_configuration
  name                     = var.user_pool_name
  tags                     = var.tags
  tags_all                 = var.tags
  user_pool_tier           = var.user_pool_tier
  username_attributes      = var.username_attributes

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = var.allow_admin_create_user_only
  }

  email_configuration {
    configuration_set      = null
    email_sending_account  = "COGNITO_DEFAULT"
    from_email_address     = null
    reply_to_email_address = null
    source_arn             = null
  }

  password_policy {
    minimum_length                   = var.password_minimum_length
    password_history_size            = var.password_history_size
    require_lowercase                = var.password_require_lowercase
    require_numbers                  = var.password_require_numbers
    require_symbols                  = var.password_require_symbols
    require_uppercase                = var.password_require_uppercase
    temporary_password_validity_days = var.temporary_password_validity_days
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true
    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "name"
    required                 = true
    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

  sign_in_policy {
    allowed_first_auth_factors = var.allowed_first_auth_factors
  }

  username_configuration {
    case_sensitive = var.username_case_sensitive
  }

  verification_message_template {
    default_email_option  = "CONFIRM_WITH_CODE"
    email_message         = null
    email_message_by_link = null
    email_subject         = null
    email_subject_by_link = null
    sms_message           = null
  }
}

resource "aws_cognito_user_pool_client" "this" {
  access_token_validity                         = var.access_token_validity
  allowed_oauth_flows                           = var.allowed_oauth_flows
  allowed_oauth_flows_user_pool_client          = var.allowed_oauth_flows_user_pool_client
  allowed_oauth_scopes                          = var.allowed_oauth_scopes
  auth_session_validity                         = var.auth_session_validity
  callback_urls                                 = var.callback_urls
  default_redirect_uri                          = null
  enable_propagate_additional_user_context_data = false
  enable_token_revocation                       = true
  explicit_auth_flows                           = var.explicit_auth_flows
  generate_secret                               = null
  id_token_validity                             = var.id_token_validity
  logout_urls                                   = var.logout_urls
  name                                          = var.client_name
  prevent_user_existence_errors                 = "ENABLED"
  read_attributes                               = []
  refresh_token_validity                        = var.refresh_token_validity
  supported_identity_providers                  = var.supported_identity_providers
  user_pool_id                                  = aws_cognito_user_pool.this.id
  write_attributes                              = []

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}
