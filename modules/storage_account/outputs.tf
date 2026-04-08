##############################################################################
# File:         modules/storage_account/outputs.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-08
#
# Purpose:
#   Outputs for Storage Account + Blob Container module
##############################################################################

output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.main.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.main.name
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = azurerm_storage_account.main.primary_blob_endpoint
}

output "container_id" {
  description = "ID of the blob container"
  value       = azurerm_storage_container.main.id
}

output "container_name" {
  description = "Name of the blob container"
  value       = azurerm_storage_container.main.name
}
