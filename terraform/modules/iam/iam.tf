
# iam_policy
resource "aws_iam_policy" "lambda_cost_notice" {
  name   = "${var.env}-${var.sys_name}-lambda-cost-notice"
  policy = file("${path.module}/policies/lambda-cost-notice.json")
}

# iam role
resource "aws_iam_role" "lambda_cost_notice" {
  name = "${var.env}-${var.sys_name}-lambda-cost-notice"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_attach" {
  role       = aws_iam_role.lambda_cost_notice.name
  policy_arn = aws_iam_policy.lambda_cost_notice.arn
}

output "iam_role_lambda_cost_notice" {
  value = aws_iam_role.lambda_cost_notice
}
