module "cloudtrail-alarm-security-group-event" {
  source                    = "../.."
  cloudtrail_log_group_name = "${var.cloudtrail_log_group_name}"
  metric_filter_pattern     = "{ ($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupEgress) || ($.eventName = CreateSecurityGroup) || ($.eventName = DeleteSecurityGroup) }"
  metric_name               = "SecurityGroupEvents"
  alarm_name                = "${var.namespace}-cloudtrail-security-group-event"
  alarm_description         = "Alarms when Security Groups configuration is changed."
  alarm_actions             = ["${var.alarm_actions}"]
}
