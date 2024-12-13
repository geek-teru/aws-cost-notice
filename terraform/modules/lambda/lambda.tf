resource "aws_lambda_function" "lambda_function" {
  function_name = "${var.env}-${var.sys_name}-cost-notice"
  timeout       = 60
  role          = var.iam_role_arn

  package_type = "Image"
  image_uri    = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.env}/${var.sys_name}-cost-notice:latest"

  environment {
    variables = {
      SLACK_AWS_BOT_TOKEN = var.slack_aws_bot_token
    }
  }

  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/${var.env}-${var.sys_name}-cost-notice"
  }
}
