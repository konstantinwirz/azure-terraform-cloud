resource "azurerm_resource_group" "test" {
  location = "northeurope"
  name     = "test"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_resource_group" "test2" {
  location = "northeurope"
  name     = "test2"

  tags = {
    environment = "dev"
  }
}
