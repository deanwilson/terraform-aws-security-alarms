module "cloudtrail-alarm-root-account-activity" {
  source                    = "../.."
  cloudtrail_log_group_name = "${var.cloudtrail_log_group_name}"
  metric_filter_pattern     = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"
  metric_name               = "RootAccessEventCount"
  alarm_name                = "${var.namespace}-cloudtrail-root-account-activity"
  alarm_description         = "Alarms when root account is used."
  alarm_actions             = ["${var.alarm_actions}"]
}
