terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

module "resource_group" {
  source  = "./modules/resource_group" 
  name    = "${var.prefix}-rg-${var.location}-${var.environment}"
  location = var.location
}

module "network" {
  source  = "./modules/network"
  prefix  = var.prefix
  location = var.location
  environment = var.environment
  app_subnet_cidr = var.app_subnet_cidr
}

module "app_service" {
  source  = "./modules/app_service"
  prefix  = var.prefix
  location = var.location
  environment = var.environment
}