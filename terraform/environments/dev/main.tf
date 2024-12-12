
module "iam" {
  source = "../../modules/iam"

  env      = var.env
  sys_name = var.sys_name
}

module "lambda" {
  source = "../../modules/lambda"

  env                 = var.env
  sys_name            = var.sys_name
  aws_account_id      = data.aws_caller_identity.current.account_id
  aws_region          = var.aws_region
  slack_aws_bot_token = var.SLACK_AWS_BOT_TOKEN

  iam_role_arn = module.iam.iam_role_lambda_cost_notice.arn
}
