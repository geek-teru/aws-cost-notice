resource "aws_lambda_function" "lambda_function" {
  function_name = "${var.env}-${var.sys_name}-cost-notice"
  handler       = cost_notice.lambda_handler
  timeout       = 60
  role          = aws_iam_role.lambda_exec.arn
  package_type  = "Image"

  #TODO: change later 
  #image_uri = "123456789012.dkr.ecr.us-east-1.amazonaws.com/my-lambda-image:latest"

  logging_config {
    log_format = "Text"
    log_group = "/aws/lambda/${var.lambda_vars.function_name}"
  }
}