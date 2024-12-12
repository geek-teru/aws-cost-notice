resource "aws_lambda_function" "lambda_function" {
  function_name = "${var.env}-${var.sys_name}-cost-notice"
  handler       = cost_notice.lambda_handler
  timeout       = 60
  role          = aws_iam_role.lambda_exec.arn
  package_type  = "Image"

  #TODO: change later 
  #image_uri = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.env}-${var.sys_name}-cost-notice:latest"

  environment {
    variables = {
      SLACK_TOKEN = var.slack_token
    }
  }

  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/${var.env}-${var.sys_name}-cost-notice"
  }
}
