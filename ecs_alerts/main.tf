provider "aws" {
  region     = "us-west-2"
  access_key = "AKIA2BXZ63WINMFXZCMW"
  secret_key = "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"
}
module "ecs_task_failure_alert" {
  source  = "../modules/ecs_task_failure_alert"
  sns_topic_name = "ecs-task-failure-sns"
  alert_rule_name = "ecs-task-failure-alert"
  alert_rule_description = "Sends SNS notifications for failed ECS tasks"
}
