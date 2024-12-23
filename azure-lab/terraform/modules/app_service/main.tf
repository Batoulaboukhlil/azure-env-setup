resource "azurerm_app_service_plan" "main" {
  name                = "${var.prefix}-app-service-plan-${var.location}-${var.environment}"
  resource_group_name  = azurerm_resource_group.main.name
  location            = var.location
  sku_name            = "F1" # Free tier
  os_type             = "linux"
  reserved           = true
}

resource "azurerm_app_service" "main" {
  name                = "${var.prefix}-app-service-${var.location}-${var.environment}"
  resource_group_name  = azurerm_resource_group.main.name
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.main.id
  https_only          = true
  site_config {
    min_tls_version = "1.2"
  }
  site_configs {
    linux_fx_version = "DOTNET|8.0" 
  }
}

output "app_service_url" {
  value = azurerm_app_service.main.default_site_hostname
}