variable "alarm_actions" {
  description = "Actions to take when the alarm occurs"
  type        = "list"
}

variable "cloudtrail_log_group_name" {
  description = "CloudTrail log group name"
  type        = "string"
}

variable "namespace" {
  default     = "cloudtrail"
  description = "An identifier used to group all resources created by this module"
  type        = "string"
}
