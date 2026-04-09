##############################################################################
# File:         modules/virtual_machine/variables.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-09
# Status:       Development
#
# Purpose:
#   Input variables for the Virtual Machine module.
#
# Revision History:
#   1.0.0   2026-04-09 DD  Initial release
##############################################################################

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "portfolio-vm"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B2ats_v2"
}

variable "availability_zone" {
  description = "Availability zone for the VM"
  type        = string
  default     = "1"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key for VM authentication"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to attach the VM to"
  type        = string
}

variable "nsg_id" {
  description = "ID of the Network Security Group to associate with the VM NIC"
  type        = string
}

variable "managed_identity_id" {
  description = "ID of the User Assigned Managed Identity"
  type        = string
}

variable "os_disk_storage_type" {
  description = "Storage account type for the OS disk"
  type        = string
  default     = "Premium_LRS"
}

variable "os_disk_size_gb" {
  description = "Size of the OS disk in GB"
  type        = number
  default     = 64
}

variable "image_publisher" {
  description = "Publisher of the VM image"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Offer of the VM image"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  description = "SKU of the VM image"
  type        = string
  default     = "22_04-lts-gen2"
}

variable "image_version" {
  description = "Version of the VM image"
  type        = string
  default     = "latest"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
