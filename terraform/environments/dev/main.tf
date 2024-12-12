
module "iam" {
  source = "../../modules/iam"

  env        = var.env
  sys_name   = var.sys_name
  account_id = data.aws_caller_identity.current.account_id
}

# module "lambda" {
#   source = "../modules/lambda"

#   env        = var.env
#   sys_name   = var.sys_name
#   aws_account_id = data.aws_caller_identity.current.account_id
#   aws_region = var.aws_region
#   slack_token = var.SLACK_TOKEN
# }
