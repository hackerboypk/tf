output "sns_topic_arn" {
  value = aws_sns_topic.ecs_task_failure_sns.arn
}

output "event_rule_name" {
  value = aws_cloudwatch_event_rule.ecs_task_failure_alert.name
}
