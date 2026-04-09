##############################################################################
# File:         modules/virtual_machine/outputs.tf
# Author:       Deepak Devaraj
# Version:      1.0.0
# Date:         2026-04-09
# Status:       Development
#
# Purpose:
#   Output values from the Virtual Machine module.
#
# Revision History:
#   1.0.0   2026-04-09 DD  Initial release
##############################################################################

output "vm_id" {
  description = "ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.main.id
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_linux_virtual_machine.main.name
}

output "vm_public_ip" {
  description = "Public IP address of the virtual machine"
  value       = azurerm_public_ip.vm_public_ip.ip_address
}

output "vm_private_ip" {
  description = "Private IP address of the virtual machine"
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

output "vm_nic_id" {
  description = "ID of the network interface"
  value       = azurerm_network_interface.vm_nic.id
}
