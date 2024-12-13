resource "aws_cloudwatch_metric_alarm" "lambda_error_alarm" {
  alarm_name  = "${var.env}-${var.sys_name}-cost-notice-error"
  metric_name = "Errors"
  namespace   = "AWS/Lambda"
  dimensions = {
    "FunctionName" = aws_lambda_function.lambda_function.function_name
  }

  period              = 300
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Maximum"
  threshold           = 1
  evaluation_periods  = 1
  datapoints_to_alarm = 1


  treat_missing_data = "breaching"

  actions_enabled = "true"
  alarm_actions   = [aws_sns_topic.sns_topic.arn]
  ok_actions      = [aws_sns_topic.sns_topic.arn]
}

resource "aws_sns_topic" "sns_topic" {
  name = "${var.env}-${var.sys_name}-cost-notice-topic"
}
