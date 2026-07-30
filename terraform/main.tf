locals {
  stack = "${var.app}-dev-${var.location}"

  default_tags = {
    environment = "dev"
    owner       = "FD"
    app         = var.app
  }

}

resource "azurerm_resource_group" "az204lib" {
  name     = "${var.resource_group_name}"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "az204lib" {
  name                = "log-${local.stack}"
  location            = azurerm_resource_group.az204lib.location
  resource_group_name = azurerm_resource_group.az204lib.name

  tags = local.default_tags
}