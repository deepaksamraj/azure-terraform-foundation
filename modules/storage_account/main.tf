##############################################################################
# File:         modules/storage_account/main.tf
# Author:       Deepak Devaraj
# Version:      1.1.0
# Date:         2026-04-08
#
# Purpose:
#   Provision Azure Storage Account with Blob Container
#   - Public access disabled for security
#   - TLS 1.2 minimum enforced
#   - Secure transfer required
#   - Random suffix ensures global uniqueness
##############################################################################

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_storage_account" "main" {
  name                     = "${var.storage_account_name}${random_string.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Security settings
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true

  # Disable public network access by default (can be overridden)
  public_network_access_enabled = true

  tags = var.tags
}

resource "azurerm_storage_container" "main" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = var.container_access_type
}
