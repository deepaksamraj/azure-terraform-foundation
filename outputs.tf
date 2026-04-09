output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "vm_name" {
  value = module.virtual_machine.vm_name
}

output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = module.virtual_machine.vm_public_ip
}

output "vm_private_ip" {
  description = "Private IP address of the VM"
  value       = module.virtual_machine.vm_private_ip
}

# =============================================================================
# Storage Account Outputs
# =============================================================================

output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage_account.storage_account_name
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = module.storage_account.storage_account_primary_blob_endpoint
}

output "container_name" {
  description = "Name of the blob container"
  value       = module.storage_account.container_name
}

# =============================================================================
# Managed Identity Outputs
# =============================================================================

output "identity_name" {
  description = "Name of the user-assigned managed identity"
  value       = azurerm_user_assigned_identity.vm_identity.name
}

output "identity_client_id" {
  description = "Client ID of the managed identity"
  value       = azurerm_user_assigned_identity.vm_identity.client_id
}

output "identity_principal_id" {
  description = "Principal ID of the managed identity"
  value       = azurerm_user_assigned_identity.vm_identity.principal_id
}

# =============================================================================
# Azure Monitor Alert Outputs
# =============================================================================

output "alert_name" {
  description = "Name of the metric alert"
  value       = module.monitor_alert.alert_name
}

output "alert_id" {
  description = "ID of the metric alert"
  value       = module.monitor_alert.alert_id
}
