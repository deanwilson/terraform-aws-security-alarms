variable "alarm_actions" {
  type        = "list"
  description = "Actions to execute when alarm transitions into ALARM state.  Specified as Amazon Resource Numbers (ARN)."
}

variable "alarm_description" {
  type        = "string"
  description = "The description for the alarm."
  default     = ""
}

variable "alarm_name" {
  type        = "string"
  description = "Descriptive alarm name. Must be unique within the user's AWS account."
}

variable "cloudtrail_log_group_name" {
  type        = "string"
  description = "The name of the log group to associate the metric filter with."
}

variable "metric_filter_pattern" {
  type        = "string"
  description = "CloudWatch Logs filter pattern for extracting metric data out of ingested log events."
}

variable "metric_name" {
  type        = "string"
  description = "CloudWatch metric name to publish monitored log information to."
}
