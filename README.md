# terraform-aws-security-alarms

A collection of AWS CloudWatch alarms for potential security issues

## Usage

Using the alarms themselves requires you to call each of the modules you
want to incorporate:

    module "root-account-activity-alarm" {
      source    = "aws-security-alarms/modules/root-account-activity"
      namespace = "unixdaemon"

      cloudtrail_log_group_name = "${module.cloudtrail.cloudtrail_log_group_name}"
      alarm_actions             = ["${module.admin-sns-email-topic.arn}"]
    }

You will need to provide a few other resources for this to work, a working
CloudTrail implementation and an alarm action endpoint. I use two of my own
modules for this:

[CloudTrail Configuration Terraform module](https://github.com/deanwilson/terraform-aws-cloudtrail)

    module "cloudtrail" {
      source    = "./deanwilson-cloudtrail"
      namespace = "unixdaemon"
    }

And my [Email backed SNS topic module](https://github.com/deanwilson/tf_sns_email)

    module "admin-sns-email-topic" {
      source = "github.com/deanwilson/tf_sns_email"

      display_name  = "Example.org Admin Notifications"
      email_address = "example@example.org"
      owner         = "Example.org:Admin"
      stack_name    = "admin-sns-email"
    }

## Alarms

The available alarms are listed below

### Root activity alarm

You should not be using your root AWS account. If anyone does access it then you
should be aware and followup on why.

    module "root-account-activity-alarm" {
      source    = "terraform-aws-security-alarms/modules/root-account-activity"
      namespace = "unixdaemon"

      cloudtrail_log_group_name = "${module.cloudtrail.cloudtrail_log_group_name}"
      alarm_actions             = ["${module.admin-sns-email-topic.arn}"]
    }

### Security Group Activity

Security groups are one of the most important security related AWS resources and
you should be explicitly aware of any changes made to them. This module adds an
alarm that notifies on any events that modify, add, or remove them.

    module "security-group-alarm" {
      source    = "terraform-aws-security-alarms/modules/security-group-event"
      namespace = "unixdaemon"

      cloudtrail_log_group_name = "${module.cloudtrail.cloudtrail_log_group_name}"
      alarm_actions             = ["${module.admin-sns-email-topic.arn}"]
    }

The actual alarms raised from this module do not contain the explicit details
of what changed. Instead you will need to look at your CloudTrail / CloudWatch
Logs / AWS Config dashboards to pinpoint the actual change. Hopefully this can
be improved in the future.

### CloudTrail Activity

CloudTrail is the essential core of your AWS audit and security efforts. Every
change made to it should be known and investigated.

    module "cloudtrail-event-alarm" {
      source    = "terraform-aws-security-alarms/modules/cloudtrail-event"
      namespace = "unixdaemon"

      cloudtrail_log_group_name = "${module.cloudtrail.cloudtrail_log_group_name}"
      alarm_actions             = ["${module.admin-sns-email-topic.arn}"]
    }

### Network ACL Activity

Network ACLs are one of the lines of defence an attacker will seek to
compromise. This alarm notifies you of any changes to them.

    module "network-acl-event-alarm" {
      source    = "terraform-aws-security-alarms/modules/network-acl-event"
      namespace = "unixdaemon"

      cloudtrail_log_group_name = "${module.cloudtrail.cloudtrail_log_group_name}"
      alarm_actions             = ["${module.admin-sns-email-topic.arn}"]
    }

### Unauthorised API Events

Alarm on unauthorised API calls.

    module "unauthorised-api-event-alarm" {
      source    = "terraform-aws-security-alarms/modules/unauthorised-api-event"
      namespace = "unixdaemon"

      cloudtrail_log_group_name = "${module.cloudtrail.cloudtrail_log_group_name}"
      alarm_actions             = ["${module.admin-sns-email-topic.arn}"]
    }

### Console Signin Failure

Work in progress. Raise alerts when someone fails to log into your AWS console.

    module "console-signin-failure-alarm" {
      source    = "terraform-aws-security-alarms/modules/console-signin-failure"
      namespace = "unixdaemon"

      cloudtrail_log_group_name = "${module.cloudtrail.cloudtrail_log_group_name}"
      alarm_actions             = ["${module.admin-sns-email-topic.arn}"]
    }

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alarm_actions | Actions to execute when alarm transitions into ALARM state.  Specified as Amazon Resource Numbers (ARN). | list | - | yes |
| alarm_description | The description for the alarm. | string | `` | no |
| alarm_name | Descriptive alarm name. Must be unique within the user's AWS account. | string | - | yes |
| cloudtrail_log_group_name | The name of the log group to associate the metric filter with. | string | - | yes |
| metric_filter_pattern | CloudWatch Logs filter pattern for extracting metric data out of ingested log events. | string | - | yes |
| metric_name | CloudWatch metric name to publish monitored log information to. | string | - | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### Authors

 * Ana Fernandez del Alamo
 * [Dean Wilson](https://www.unixdaemon.net)

### License

This module is released under the Mozilla Public License 2.0, the
same license as Terraform itself.
