##############################################################################
# File:         modules/monitor_alert/variables.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-08
#
# Purpose:
#   Variables for Azure Monitor Alert module
##############################################################################

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the alert"
}

variable "vm_id" {
  type        = string
  description = "ID of the VM to monitor"
}

variable "alert_name" {
  type        = string
  description = "Name of the alert rule"
  default     = "vm-cpu-high"
}

variable "alert_description" {
  type        = string
  description = "Description of the alert rule"
  default     = "Alert when VM CPU usage exceeds threshold"
}

variable "metric_namespace" {
  type        = string
  description = "Metric namespace for the alert"
  default     = "Microsoft.Compute/virtualMachines"
}

variable "metric_name" {
  type        = string
  description = "Metric to monitor (e.g., Percentage CPU)"
  default     = "Percentage CPU"
}

variable "aggregation" {
  type        = string
  description = "Aggregation type for the metric"
  default     = "Average"
}

variable "operator" {
  type        = string
  description = "Comparison operator (GreaterThan, LessThan, etc.)"
  default     = "GreaterThan"
}

variable "threshold" {
  type        = number
  description = "Threshold value for the alert"
  default     = 80
}

variable "window_size" {
  type        = string
  description = "Time window for evaluation (e.g., PT5M for 5 minutes)"
  default     = "PT5M"
}

variable "evaluation_frequency" {
  type        = string
  description = "How often to evaluate the metric (e.g., PT1M for 1 minute)"
  default     = "PT1M"
}

variable "alert_severity" {
  type        = number
  description = "Severity level (0=Critical, 1=Error, 2=Warning, 3=Informational, 4=Verbose)"
  default     = 3
}

variable "action_group_ids" {
  type        = list(string)
  description = "List of action group IDs to notify"
  default     = []
}

variable "auto_mitigate" {
  type        = bool
  description = "Whether to auto-resolve the alert when condition clears"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
