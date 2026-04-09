##############################################################################
# File:         main.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-08
# Status:       Development
#
# Purpose:
#   Provision the staging VPC and associated subnets.
#
# Usage:
#   
#
# Dependencies:
#   Terraform >= 1.14.8, Azure CLI provider ~> 2.84.0
#
# Environment:
#   
#
# Revision History:
#   1.0.0   2026-04-08  Initial release
#   1.0.1   2026-04-09  Updated modules
##############################################################################

provider "azurerm" {
  skip_provider_registration = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "dev"
    Project     = "portfolio"
    ManagedBy   = "terraform"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = "dev"
    Project     = "portfolio"
    ManagedBy   = "terraform"
  }
}

resource "azurerm_subnet" "public" {
  name                 = "public-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.public_subnet_cidr]
}

resource "azurerm_subnet" "private" {
  name                 = "private-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.private_subnet_cidr]
}

resource "azurerm_network_security_group" "public_nsg" {
  name                = "nsg-public"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    Environment = "dev"
    Project     = "portfolio"
    ManagedBy   = "terraform"
  }
}

# Allow SSH from your IP only
resource "azurerm_network_security_rule" "ssh_inbound" {
  name                       = "allow-ssh"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = var.my_ip
  destination_address_prefix = "*"

  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.public_nsg.name
}

# Allow HTTP from anywhere
resource "azurerm_network_security_rule" "http_inbound" {
  name                       = "allow-http"
  priority                   = 200
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "*"
  destination_address_prefix = "*"

  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.public_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "public_assoc" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public_nsg.id
}

# =============================================================================
# Virtual Machine
# =============================================================================

module "virtual_machine" {
  source = "./modules/virtual_machine"

  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  vm_name             = "portfolio-vm"
  vm_size             = "Standard_B2ats_v2"
  availability_zone   = "1"
  admin_username      = "azureuser"
  ssh_public_key      = file("~/.ssh/azure_key.pub")
  subnet_id           = azurerm_subnet.public.id
  nsg_id              = azurerm_network_security_group.public_nsg.id
  managed_identity_id = azurerm_user_assigned_identity.vm_identity.id

  tags = {
    Environment = "dev"
    Project     = "portfolio"
    ManagedBy   = "terraform"
  }
}

# =============================================================================
# Storage Account + Blob Container
# =============================================================================

module "storage_account" {
  source = "./modules/storage_account"

  resource_group_name   = azurerm_resource_group.main.name
  location              = var.location
  storage_account_name  = var.storage_account_name
  container_name        = var.container_name
  container_access_type = var.container_access_type

  tags = {
    Environment = "dev"
    Project     = "portfolio"
    ManagedBy   = "terraform"
  }
}

# =============================================================================
# Managed Identity
# =============================================================================

resource "azurerm_user_assigned_identity" "vm_identity" {
  name                = var.identity_name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location

  tags = {
    Environment = "dev"
    Project     = "portfolio"
    ManagedBy   = "terraform"
  }
}

# Assign Storage Blob Data Contributor role to the managed identity
resource "azurerm_role_assignment" "vm_storage_role" {
  scope                = module.storage_account.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.vm_identity.principal_id
}

# =============================================================================
# Azure Monitor Alert
# =============================================================================

module "monitor_alert" {
  source = "./modules/monitor_alert"

  resource_group_name  = azurerm_resource_group.main.name
  location             = var.location
  vm_id                = module.virtual_machine.vm_id
  alert_name           = var.alert_name
  alert_description    = var.alert_description
  metric_name          = var.metric_name
  aggregation          = var.aggregation
  operator             = var.operator
  threshold            = var.threshold
  window_size          = var.window_size
  evaluation_frequency = var.evaluation_frequency
  alert_severity       = var.alert_severity

  tags = {
    Environment = "dev"
    Project     = "portfolio"
    ManagedBy   = "terraform"
  }
}
