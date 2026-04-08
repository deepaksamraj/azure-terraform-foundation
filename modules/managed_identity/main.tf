##############################################################################
# File:         modules/managed_identity/main.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-08
#
# Purpose:
#   Provision User-Assigned Managed Identity and assign to VM
#   - Enables secure, passwordless access to Azure resources
#   - No credentials to manage or rotate
##############################################################################

resource "azurerm_user_assigned_identity" "main" {
  name                = var.identity_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}
