resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-vnet-${var.location}-${var.environment}"
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "app" {
  name                 = "${var.prefix}-subnet-app-${var.location}-${var.environment}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["${var.app_subnet_cidr}"]
}

output "app_subnet_id" {
  value = azurerm_subnet.app.id
}