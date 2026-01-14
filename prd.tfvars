#========================================================================================#
#                                  VPC VARIABLES                                         #
#========================================================================================#

# Range de IP da VPC
vpc_cidr = "10.1.0.0/16"

# Número de AZs
number_of_azs = 2

# Decide se terá IPV6 ou não 
enable_ipv6 = false

# Decidem quais subnets que serão criadas
create_public_subnets = true
create_app_subnets    = true
create_data_subnets   = true

# Decide se criará NAT Gateway ou não
create_nat = true

# Decide se o NAT Gateway será de alta disponibilidade ou não
nat_gateway_high_availability = false

# Variáveis adicionais necessárias
prefix_name      = "vdsc"
environment_name = "prd"

#========================================================================================#
#                                 OPENVPN VARIABLES                                      #
#========================================================================================#

# Tipo de instância da OpenVPN
openvpn_instance_type = "t4g.small"


#========================================================================================#
#                               API GATEWAY VARIABLES                                   #
#========================================================================================#

api_gateway_cors = {
  allow_credentials = false
  allow_headers     = ["content-type", "x-amz-date", "authorization", "x-api-key"]
  allow_methods     = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
  allow_origins     = ["*"]
  max_age           = 86400
}

api_gateway_throttle = {
  burst_limit = 5000
  rate_limit  = 10000
}

#========================================================================================#
#                                ECR VARIABLES                                          #
#========================================================================================#

ecr_repository_names     = ["app"]
ecr_image_tag_mutability = "MUTABLE"
ecr_scan_on_push         = true

#========================================================================================#
#                               CODEBUILD VARIABLES                                     #
#========================================================================================#

codebuild_projects = {
  "iac" = {
    codebuild_name  = "vdsc-prd-codebuild-iac"
    github_repo_url = "https://github.com/11soat-hackton-videoslice/iac"
  },
  "ms-failover" = {
    codebuild_name  = "vdsc-prd-codebuild-failover"
    github_repo_url = "https://github.com/11soat-hackton-videoslice/ms-video-failover"
  },
  "ms-status-management" = {
    codebuild_name  = "vdsc-prd-codebuild-status-management"
    github_repo_url = "https://github.com/11soat-hackton-videoslice/ms-status-management"
  },
  "ms-video-slice" = {
    codebuild_name  = "vdsc-prd-codebuild-video-slice"
    github_repo_url = "https://github.com/11soat-hackton-videoslice/ms-video-slice"
  },
  "ms-video-upload-url" = {
    codebuild_name  = "vdsc-prd-codebuild-video-upload-url"
    github_repo_url = "https://github.com/11soat-hackton-videoslice/ms-video-upload-url"
  },
  "ms-download-url" = {
    codebuild_name  = "vdsc-prd-codebuild-download-url"
    github_repo_url = "https://github.com/11soat-hackton-videoslice/ms-video-download-url"
  }
}
codebuild_compute_type = "BUILD_GENERAL1_SMALL"

#========================================================================================#
#                            SECRETS MANAGER VARIABLES                                 #
#========================================================================================#

secrets_manager_recovery_window = 7
