module "cloudtrail-alarm-unauthorised-api-event" {
  source                    = "../.."
  cloudtrail_log_group_name = "${var.cloudtrail_log_group_name}"
  metric_filter_pattern     = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"
  metric_name               = "AuthorizationFailureCount"
  alarm_name                = "${var.namespace}-cloudtrail-unauthorised-api-event"
  alarm_description         = "Alarms when unauthorised API calls are logged."
  alarm_actions             = ["${var.alarm_actions}"]
}
