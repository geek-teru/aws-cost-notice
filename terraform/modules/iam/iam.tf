
# iam_policy
resource "aws_iam_policy" "iam_policy" {
  name = "${var.env}-${var.sys_name}-lambda-cost-notice-role"
  policy = file("${path.module}/lambda-cost-notice-role.json")
}

# iam role
resource "aws_iam_role" "iam_role" {
  name = var.iam_role_config.name

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
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}