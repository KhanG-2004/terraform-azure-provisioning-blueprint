output "resource_group_name" {
  description = "The assigned name of the primary resource group"
  value       = azurerm_resource_group.infra_rg.name
}

output "vnet_id" {
  description = "The unique Azure ID of the virtual network"
  value       = azurerm_virtual_network.core_vnet.id
}

output "web_subnet_id" {
  description = "The resource ID of the web tier subnet"
  value       = azurerm_subnet.web_subnet.id
}
