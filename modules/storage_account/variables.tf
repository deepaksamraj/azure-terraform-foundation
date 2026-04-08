##############################################################################
# File:         modules/storage_account/variables.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-08
#
# Purpose:
#   Variables for Storage Account + Blob Container module
##############################################################################

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for the storage account"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account (must be globally unique, 3-24 chars, lowercase letters and numbers only)"
}

variable "container_name" {
  type        = string
  description = "Name of the blob container"
  default     = "data"
}

variable "container_access_type" {
  type        = string
  description = "Access type for the blob container (private, blob, container)"
  default     = "private"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
