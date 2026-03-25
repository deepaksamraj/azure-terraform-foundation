##############################################################################
# File:         variables.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         25-05-2026
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
#   1.0.0   25-05-2026 DD  Initial release
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

