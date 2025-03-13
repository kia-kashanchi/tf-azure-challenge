output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "subnet_id" {
  description = "The ID of the default subnet"
  value       = azurerm_subnet.default.id
}