module "cloudtrail-alarm-console-signin-failure" {
  source                    = "../.."
  cloudtrail_log_group_name = "${var.cloudtrail_log_group_name}"
  metric_filter_pattern     = "{ ($.eventName = ConsoleLogin) && ($.errorMessage = \"Failed authentication\") }"
  metric_name               = "ConsoleSigninFailureCount"
  alarm_name                = "${var.namespace}-cloudtrail-console-signing-event"
  alarm_description         = "Alarms when console signins fail."
  alarm_actions             = ["${var.alarm_actions}"]
}
