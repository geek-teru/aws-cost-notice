import datetime
import pytz
import boto3

from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError

SLACK_CHANNEL = "aws-cost-notice"

def get_monthly_cost(start_date, end_date):
    client = boto3.client('ce', region_name='us-east-1')

    response = client.get_cost_and_usage(
        TimePeriod={
            'Start': start_date,
            'End': end_date
        },
        Granularity='MONTHLY',
        Metrics=['BlendedCost']
    )
    # 小数点第3位を切り捨て
    monthly_cost = round(
        float(response["ResultsByTime"][0]["Total"]["BlendedCost"]["Amount"]), 2)

    return monthly_cost


def get_itemized_cost(start_date, end_date):
    client = boto3.client('ce', region_name='us-east-1')

    response = client.get_cost_and_usage(
        TimePeriod={
            'Start': start_date,
            'End': end_date
        },
        Granularity='MONTHLY',
        Metrics=['BlendedCost'],
        GroupBy=[
            {
                'Type': 'DIMENSION',
                'Key': 'SERVICE'
            }
        ]
    )
    service_cost = []
    for item in response["ResultsByTime"][0]["Groups"]:
        cost = {}
        # cost["service_name"] = "xx.xx USD"の形式
        cost[item["Keys"][0]] = str(
            round(float(item["Metrics"]["BlendedCost"]["Amount"]), 2)) + " USD"
        service_cost.append(cost)

    return service_cost

# Slackに通知する処理
def post_slack(channel, message_text):
  attachments = [
    {
      "fallback":"AWS Cost Notice",
      "color":"#2cb47c",
      "fields":[
        {
          "title": "AWS Cost Notice",
          "value": message_text
        }
      ]
    }
  ]
  client = WebClient(SLACK_TOKEN)
  try:
    result = client.chat_postMessage(channel = channel, attachments = attachments)
  except SlackApiError as e:
    print(f"[ERROR]post_slack failed. {e.response['error']}")


def lambda_handler(event, context):
    # 日付を取得
    now = datetime.datetime.now(pytz.timezone('Asia/Tokyo'))
    yesterday = (now - datetime.timedelta(days=1))
    yesterday_str = yesterday.strftime('%Y-%m-%d')
    this_month_first_day_str = datetime.datetime(
        yesterday.year, yesterday.month, 1).strftime('%Y-%m-%d')

    # 当月の利用料を取得
    monthly_cost = get_monthly_cost(this_month_first_day_str, yesterday_str)

    # 利用料の明細を取得
    itemized_cost = get_itemized_cost(this_month_first_day_str, yesterday_str)
    itemized_cost_str = "\n".join([str(item) for item in itemized_cost])

    message = f"{yesterday_str}までの{yesterday.month}月分の利用料金は{monthly_cost}USDです。\n\nサービス別の利用料金の以下の通りです。\n\n{itemized_cost_str}"
    print(message)
    post_slack(SLACK_CHANNEL, message)


if __name__ == "__main__":
    lambda_handler("", "")
