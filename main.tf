resource "azurerm_resource_group" "test" {
  location = "northeurope"
  name     = "test"

  tags = {
    environment = "dev"
  }
}
