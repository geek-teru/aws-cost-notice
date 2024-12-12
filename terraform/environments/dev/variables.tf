variable "env" {
  type = string
}

variable "sys_name" {
  type = string
}

data "aws_caller_identity" "current" {}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

# --------------------------------
# environment variable
# --------------------------------
variable "SLACK_TOKEN" {
  type    = string
  default = ""
}
