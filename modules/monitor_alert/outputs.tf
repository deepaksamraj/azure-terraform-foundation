##############################################################################
# File:         modules/monitor_alert/outputs.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-08
#
# Purpose:
#   Outputs for Azure Monitor Alert module
##############################################################################

output "alert_id" {
  description = "ID of the metric alert"
  value       = azurerm_monitor_metric_alert.main.id
}

output "alert_name" {
  description = "Name of the metric alert"
  value       = azurerm_monitor_metric_alert.main.name
}
