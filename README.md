# aws-cost-notice

## 概要
* AWSコスト通知用Lambda Function
* Lambdaはコンテナで実行する
* AWSリソースはTerraformで定義して、GitHub Actionsでデプロイする
* LambdaのイメージのアップデートもGitHub Actionsで実行する

## 事前準備
* Slack APPを作成し,通知先チャンネルに追加しておく
* ECRリポジトリを作成しておく

## Lambdaテスト手順
```
#To build you image:
docker build -t aws-cost-notice .

#To run your image locally:
docker run -d -p 9000:8080 \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  aws-cost-notice

# In a separate terminal, you can then locally invoke the function using cURL:
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"payload":"hello world!"}'
```


## Terraform手順
```
# AWS credential setting
$ export AWS_ACCESS_KEY_ID=<your_access_key_id>
$ export AWS_SECRET_ACCESS_KEY=<your_secret_access_key>
$ export AWS_SESSION_TOKEN=<your_session_token>

# Terraform apply
$ docker compose run --rm terraform init
$ docker compose run --rm terraform plan -var-file=dev.tfvars
$ docker compose run --rm terraform apply -var-file=dev.tfvars
$ docker compose run --rm terraform destroy -var-file=dev.tfvars
```