variable "env" {
  type    = string
  default = "dev"
}

variable "sys_name" {
  type    = string
  default = "cmn"
}

data "aws_caller_identity" "current" {}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

# --------------------------------
# environment variable
# --------------------------------
variable "SLACK_AWS_BOT_TOKEN" {
  type    = string
  default = ""
}
