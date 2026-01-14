#========================================================================================#
#                                   VPC MODULE                                           #
#========================================================================================#

module "vpc" {
  source = "./modules/vpc"

  prefix_name          = local.prefix_name
  environment          = local.environment_name
  enable_vpc_flow_logs = false

  vpc_cidr = var.vpc_cidr

  number_of_azs = var.number_of_azs

  enable_ipv6 = var.enable_ipv6

  create_app_subnets  = var.create_app_subnets
  create_data_subnets = var.create_data_subnets

  create_nat                    = var.create_nat
  nat_gateway_high_availability = var.nat_gateway_high_availability
  eks_cluster_name              = "${local.prefix_name}-${var.environment_name}-eks"
}

#========================================================================================#
#                                 OPENVPN MODULE                                         #
#========================================================================================#

module "openvpn" {
  source = "./modules/openvpn"

  prefix_name      = local.prefix_name
  environment_name = local.environment_name
  instance_type    = var.openvpn_instance_type
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_ids[0]
}



# #========================================================================================#
# #                                LAMBDA MODULE                                          #
# #========================================================================================#

# module "lambda" {
#   source = "./modules/lambda"

#   prefix_name      = local.prefix_name
#   environment_name = local.environment_name
#   function_name    = "custom-authorizer"

#   environment_variables = {
#     ENVIRONMENT = local.environment_name
#     PREFIX      = local.prefix_name
#   }
# }

#========================================================================================#
#                             SECURITY GROUP MODULE                                     #
#========================================================================================#

module "security_group" {
  source = "./modules/security-group"

  prefix_name      = local.prefix_name
  environment_name = local.environment_name
  vpc_id           = module.vpc.vpc_id
}

#========================================================================================#
#                                API GATEWAY MODULE                                     #
#========================================================================================#

module "api_gateway" {
  source = "./modules/api-gateway"

  prefix_name      = local.prefix_name
  environment_name = local.environment_name

  cors_configuration = var.api_gateway_cors
  throttle_settings  = var.api_gateway_throttle

  lambda_function_arn  = var.lambda_function_arn
  vpc_subnet_ids       = module.vpc.app_subnet_ids
  security_group_ids   = [module.security_group.security_group_id]
  eks_nlb_listener_arn = var.eks_nlb_listener_arn

}

#========================================================================================#
#                                ECR MODULE                                             #
#========================================================================================#

module "ecr" {
  source = "./modules/ecr"

  prefix_name      = local.prefix_name
  environment_name = local.environment_name

  repository_names     = var.ecr_repository_names
  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push
}

#========================================================================================#
#                               CODEBUILD MODULE                                        #
#========================================================================================#

module "codebuild" {
  source = "./modules/codebuild"

  prefix_name      = local.prefix_name
  environment_name = local.environment_name

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.app_subnet_ids
  codebuild_projects = var.codebuild_projects
  compute_type       = var.codebuild_compute_type
}

#========================================================================================#
#                             SECRETS MANAGER MODULE                                    #
#========================================================================================#

module "secrets_manager" {
  source = "./modules/secrets-manager"

  prefix_name      = local.prefix_name
  environment_name = local.environment_name

  recovery_window_in_days = var.secrets_manager_recovery_window
}

