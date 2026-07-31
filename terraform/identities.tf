resource "azurerm_user_assigned_identity" "az204lib" {
  location            = data.azurerm_resource_group.az204lib.location
  name                = "uai_az204lib"
  resource_group_name = data.azurerm_resource_group.az204lib.name
}
resource "azurerm_role_assignment" "az204lib" {
  scope                = data.azurerm_container_registry.az204lib.id
  role_definition_name = "acrpull"
  principal_id         = azurerm_user_assigned_identity.az204lib.principal_id
  depends_on = [
    azurerm_user_assigned_identity.az204lib
  ]
}