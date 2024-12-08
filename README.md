# aws-cost-notice

## 概要
AWSコスト通知用Lambda Function

## 手順
```
# AWS credential setting
$ export AWS_ACCESS_KEY_ID=$your_access_key_id
$ export AWS_SECRET_ACCESS_KEY=$your_secret_access_key
$ export AWS_SESSION_TOKEN=$your_session_token

# Terraform apply
$ docker compose run --rm terraform init
$ docker compose run --rm terraform plan -var-file=dev.tfvars
$ docker compose run --rm terraform apply -var-file=dev.tfvars
$ docker compose run --rm terraform destroy -var-file=dev.tfvars
```