module "cloudtrail-alarm-network-acl-event" {
  source                    = "../.."
  cloudtrail_log_group_name = "${var.cloudtrail_log_group_name}"
  metric_filter_pattern     = "{ ($.eventName = CreateNetworkAcl) || ($.eventName = CreateNetworkAclEntry) || ($.eventName = DeleteNetworkAcl) || ($.eventName = DeleteNetworkAclEntry) || ($.eventName = ReplaceNetworkAclEntry) || ($.eventName = ReplaceNetworkAclAssociation) }"
  metric_name               = "NetworkACLEvents"
  alarm_name                = "${var.namespace}-cloudtrail-network-acl-event"
  alarm_description         = "Alarms when network ACL configuration is changed."
  alarm_actions             = ["${var.alarm_actions}"]
}
