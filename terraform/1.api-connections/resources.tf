### Backend ###

terraform {
  backend "azurerm" {

  }
}

### Providers ###

provider "azurerm" {
  features {}
}

### Resources ###

#Random name
resource "random_pet" "service" {}

#Resource group
resource "azurerm_resource_group" "rg" {
  name     = "salesforce-integration-poc"
  location = var.location
}

# ARM Template: Salesforce connection
resource "azurerm_template_deployment" "salesforce_connection" {
  name                = "salesforce_connection"
  resource_group_name = azurerm_resource_group.rg.name
  deployment_mode     = "Incremental"
  template_body       = file("../../arm-templates/salesforce-connection.json")

  parameters = {
    "location" = azurerm_resource_group.rg.location
  }
}

# ARM Template: Office 365 connection
resource "azurerm_template_deployment" "office365_connection" {
  name                = "office365_connection"
  resource_group_name = azurerm_resource_group.rg.name
  deployment_mode     = "Incremental"
  template_body       = file("../../arm-templates/office365-connection.json")

  parameters = {
    "location" = azurerm_resource_group.rg.location
  }
}