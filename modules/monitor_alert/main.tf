##############################################################################
# File:         modules/monitor_alert/main.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-08
#
# Purpose:
#   Provision Azure Monitor Alert for VM metrics
#   - CPU percentage alert with configurable threshold
#   - Configurable evaluation window and frequency
##############################################################################

resource "azurerm_monitor_metric_alert" "main" {
  name                = var.alert_name
  resource_group_name = var.resource_group_name
  scopes              = [var.vm_id]
  description         = var.alert_description
  severity            = var.alert_severity
  frequency           = var.evaluation_frequency
  window_size         = var.window_size
  auto_mitigate       = var.auto_mitigate

  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = var.metric_name
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.threshold
  }

  dynamic "action" {
    for_each = var.action_group_ids
    content {
      action_group_id = action.value
    }
  }

  tags = var.tags
}
