resource "aws_cloudwatch_log_metric_filter" "filter" {
  name           = "${var.metric_name}"
  pattern        = "${var.metric_filter_pattern}"
  log_group_name = "${var.cloudtrail_log_group_name}"

  metric_transformation {
    name      = "${var.metric_name}"
    namespace = "CloudTrailMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "cloudtrail" {
  alarm_name                = "${var.alarm_name}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "${var.metric_name}"
  namespace                 = "CloudTrailMetrics"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "${var.alarm_description}"
  insufficient_data_actions = []
  alarm_actions             = ["${var.alarm_actions}"]
}
