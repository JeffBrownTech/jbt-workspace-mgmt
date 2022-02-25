output "subnets" {
  value = values(azurerm_subnet)[*]
}

