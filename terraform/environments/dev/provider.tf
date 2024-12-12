# ----------------------------------------
# Provider Settings
# ----------------------------------------
provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.74.0"
    }
  }

  backend "s3" {
    bucket = "dev-terraform-aws"
    region = "ap-northeast-1"
    key    = "aws-cost-notice/terraform.tfstate"
  }
}

#resource "aws_dynamodb_table" "tfstate_lock" {
#  count = 1
#  name           = "tfstate_lock"
#  read_capacity  = 1
#  write_capacity = 1
#  hash_key       = "LockID"
#  attribute {
#    name = "LockID"
#    type = "S"
#  }
#  lifecycle {
#    ignore_changes = ["read_capacity", "write_capacity"]
#  }
#}

