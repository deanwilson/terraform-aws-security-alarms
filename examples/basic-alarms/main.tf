# use an external module to configure cloud trail
# you will also need to configure your own action endpoint

module "cloudtrail" {
  source    = "deanwilson/cloudtrail"
  namespace = "unixdaemon"
}

# add the console signing alarm
module "console-signin-failure-alarm" {
  source    = "terraform-aws-security-alarms/modules/console-signin-failure"
  namespace = "unixdaemon"

  cloudtrail_log_group_name = "${module.cloudtrail.cloudtrail_log_group_name}"
  alarm_actions             = ["${module.admin-sns-email-topic.arn}"]
}

# add the root account activity alarm. Note most of the
# code is boilerplate
module "root-account-activity-alarm" {
  source    = "terraform-aws-security-alarms/modules/root-account-activity"
  namespace = "unixdaemon"

  cloudtrail_log_group_name = "${module.cloudtrail.cloudtrail_log_group_name}"
  alarm_actions             = ["${module.admin-sns-email-topic.arn}"]
}
