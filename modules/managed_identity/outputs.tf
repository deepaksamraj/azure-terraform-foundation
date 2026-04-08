##############################################################################
# File:         modules/managed_identity/outputs.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-08
#
# Purpose:
#   Outputs for Managed Identity module
##############################################################################

output "identity_id" {
  description = "ID of the user-assigned managed identity"
  value       = azurerm_user_assigned_identity.main.id
}

output "identity_name" {
  description = "Name of the user-assigned managed identity"
  value       = azurerm_user_assigned_identity.main.name
}

output "identity_principal_id" {
  description = "Principal ID of the managed identity"
  value       = azurerm_user_assigned_identity.main.principal_id
}

output "identity_client_id" {
  description = "Client ID of the managed identity"
  value       = azurerm_user_assigned_identity.main.client_id
}
