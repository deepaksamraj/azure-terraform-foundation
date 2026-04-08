##############################################################################
# File:         modules/managed_identity/variables.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-08
#
# Purpose:
#   Variables for Managed Identity module
##############################################################################

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the managed identity"
}

variable "identity_name" {
  type        = string
  description = "Name of the user-assigned managed identity"
}

variable "vm_id" {
  type        = string
  description = "ID of the VM to assign the identity to"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
