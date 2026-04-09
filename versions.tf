##############################################################################
# File:         versions.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-09
# Status:       Development
#
# Purpose:
#   Define Terraform and provider version constraints to maintain a standard
#   reference of components used across the project and prevent accidental
#   breaking changes.
#
# Dependencies:
#   Terraform >= 1.14.8
#
# Revision History:
#   1.0.0   2026-04-09 DD  Initial release
##############################################################################

terraform {
  required_version = ">= 1.14.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.8"
    }
  }
}
