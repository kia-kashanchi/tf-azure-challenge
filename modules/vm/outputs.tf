output "vm_id" {
  description = "The ID of the Virtual Machine"
  value       = azurerm_virtual_machine.vm.id
}

output "nic_id" {
  description = "The ID of the Network Interface attached to the VM"
  value       = azurerm_network_interface.vm_nic.id
}