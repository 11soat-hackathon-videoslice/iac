data "local_file" "buildspec" {
  filename = "${path.module}/templates/buildspec.yaml"
}

resource "aws_amplify_app" "this" {
  name                        = var.app_name
  repository                  = var.repository
  iam_service_role_arn        = var.iam_service_role_arn
  build_spec                  = data.local_file.buildspec.content
  environment_variables       = var.environment_variables
  enable_branch_auto_build    = var.enable_branch_auto_build
  enable_basic_auth           = var.enable_basic_auth
  enable_auto_branch_creation = false
  enable_branch_auto_deletion = false
  platform                    = "WEB"
  tags                        = var.tags

  cache_config {
    type = "AMPLIFY_MANAGED_NO_COOKIES"
  }

  custom_rule {
    source = "/<*>"
    status = "404-200"
    target = "/index.html"
  }

  job_config {
    build_compute_type = "STANDARD_8GB"
  }
}
