resource "aws_sns_topic" "ecs_task_failure_sns" {
  name = var.sns_topic_name
}

resource "aws_cloudwatch_event_rule" "ecs_task_failure_alert" {
  name         = var.alert_rule_name
  description  = var.alert_rule_description
  event_pattern = file("${path.module}/event_rule.json")
 
}
resource "aws_cloudwatch_event_target" "sns" {
  rule = aws_cloudwatch_event_rule.ecs_task_failure_alert.name
  arn  = aws_sns_topic.ecs_task_failure_sns.arn

  input_transformer {
    input_paths = {
      "AZ"               = "$.detail.availabilityZone"
      "ECS_CLUSTER_ARN" = "$.detail.clusterArn"
      "PROBLEM"           = "$.detail-type"
      "REGION"           = "$.region"
      "SERVICE"           = "$.detail.group"
      "STOPPED_REASON"    = "$.detail.stoppedReason"
      "STOPPED_TIME"     = "$.detail.stoppedAt"
      "STOP_CODE"        = "$.detail.stopCode"
      "TASK_ARN"         = "$.detail.taskArn"
    }
    input_template = <<EOT
      "ECS TASK FAILURE ALERT"
      "Problem: <PROBLEM>"
      "Region: <REGION>"
      "Availability Zone: <AZ>"
      "ECS Cluster Arn: <ECS_CLUSTER_ARN>"
      "Service Name: <SERVICE>"
      "Task Arn: <TASK_ARN>"
      "Stopped Reason: <STOPPED_REASON>"
      "Stop Code: <STOP_CODE>"
      "Stopped Time: <STOPPED_TIME>"
    EOT
  }
}
