##############################################################################
# File:         variables.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         08-04-2026
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
#   1.0.0   08-04-2026 DD  Initial release
##############################################################################
variable "resource_group_name" {
  type        = string
  description = "rg-portfolio-dev"
}

variable "location" {
  type        = string
  description = "Azure region for all resources"
  default     = "northeurope"
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "vnet_cidr" {
  type        = string
  description = "CIDR block for the VNet"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR for public subnet"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR for private subnet"
}

variable "my_ip" {
  type        = string
  description = "Your public IP address for SSH access"
}

# =============================================================================
# Storage Account Variables
# =============================================================================

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

# =============================================================================
# Managed Identity Variables
# =============================================================================

variable "identity_name" {
  type        = string
  description = "Name of the user-assigned managed identity"
  default     = "vm-identity"
}

# =============================================================================
# Azure Monitor Alert Variables
# =============================================================================

variable "alert_name" {
  type        = string
  description = "Name of the alert rule"
  default     = "vm-cpu-high"
}

variable "alert_description" {
  type        = string
  description = "Description of the alert rule"
  default     = "Alert when VM CPU usage exceeds 80% for 5 minutes"
}

variable "metric_name" {
  type        = string
  description = "Metric to monitor"
  default     = "Percentage CPU"
}

variable "aggregation" {
  type        = string
  description = "Aggregation type for the metric"
  default     = "Average"
}

variable "operator" {
  type        = string
  description = "Comparison operator"
  default     = "GreaterThan"
}

variable "threshold" {
  type        = number
  description = "Threshold value for the alert"
  default     = 80
}

variable "window_size" {
  type        = string
  description = "Time window for evaluation"
  default     = "PT5M"
}

variable "evaluation_frequency" {
  type        = string
  description = "How often to evaluate the metric"
  default     = "PT1M"
}

variable "alert_severity" {
  type        = number
  description = "Severity level (0=Critical, 1=Error, 2=Warning, 3=Informational, 4=Verbose)"
  default     = 3
}

