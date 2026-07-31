locals {
  stack = "${var.app}-dev-${data.azurerm_resource_group.az204lib.location}"

  default_tags = {
    environment = "dev"
    owner       = "FD"
    app         = var.app
  }

}

data "azurerm_resource_group" "az204lib" {
  name     = "${var.resource_group_name}"
}

resource "azurerm_log_analytics_workspace" "az204lib" {
  name                = "log-${local.stack}"
  location            = data.azurerm_resource_group.az204lib.location
  resource_group_name = data.azurerm_resource_group.az204lib.name

  tags = local.default_tags
}