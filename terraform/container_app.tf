data "azurerm_container_registry" "az204lib" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.az204lib.name
}

resource "azurerm_container_app_environment" "az204lib" {
  name                       = "cae-${local.stack}"
  location                   = data.azurerm_resource_group.az204lib.location
  resource_group_name        = data.azurerm_resource_group.az204lib.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.az204lib.id

  tags = local.default_tags
}

resource "azurerm_container_app" "az204lib" {
  name = "ca-${local.stack}"

  container_app_environment_id = azurerm_container_app_environment.az204lib.id
  resource_group_name          = data.azurerm_resource_group.az204lib.name
  revision_mode                = "Single"

  registry {
    server               = data.azurerm_container_registry.az204lib.login_server
    username             = data.azurerm_container_registry.az204lib.admin_username
    password_secret_name = data.azurerm_container_registry.az204lib.admin_password
  }

  template {
    container {
      name   = "ca-${local.stack}"
      image  = "${var.app_image_name}:${var.app_image_tag}"
      cpu    = 0.25
      memory = "0.5Gi"
    }

    # tags = local.default_tags
  }
}

output "azurerm_container_app_url" {
  value = azurerm_container_app.az204lib.latest_revision_fqdn
}