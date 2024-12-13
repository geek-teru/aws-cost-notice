resource "aws_cloudwatch_event_rule" "event_rule" {
  name        = "${var.env}-${var.sys_name}-cost-notice-trigger"
  description = "for lambda cost notice"

  schedule_expression = "cron(0 0 * * ? *)"
}

resource "aws_cloudwatch_event_target" "event_target" {
  arn  = aws_lambda_function.lambda_function.arn
  rule = aws_cloudwatch_event_rule.event_rule.name
}
