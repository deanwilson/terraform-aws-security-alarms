module "cloudtrail-alarm-cloudtrail-event" {
  source                    = "../.."
  cloudtrail_log_group_name = "${var.cloudtrail_log_group_name}"
  metric_filter_pattern     = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"
  metric_name               = "CloudTrailEventCount"
  alarm_name                = "${var.namespace}-cloudtrail-cloudtrail-event"
  alarm_description         = "Alarms when CloudTrail configuration is changed."
  alarm_actions             = ["${var.alarm_actions}"]
}
