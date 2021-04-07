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

#ARM Template: Azure Logic App - From Salesforce to Azure
resource "azurerm_template_deployment" "from_salesforce_to_azure" {
  name                =  "from_salesforce_to_azure"
  resource_group_name = data.terraform_remote_state.api_connections.outputs.resource_group_name
  deployment_mode     = "Incremental"
  template_body       = file("../../arm-templates/from-salesforce-to-azure.json")
  parameters = {
    "api_connections_location"       = data.terraform_remote_state.api_connections.outputs.resource_group_location
    "api_connections_resource_group" = data.terraform_remote_state.api_connections.outputs.resource_group_name
    "location"                       = azurerm_resource_group.rg.location
    "recipients"                     = var.recipients
  }
}

#ARM Template: Azure Logic App - From Azure to Salesforce
resource "azurerm_template_deployment" "from_azure_to_salesforce" {
  name                = "from_azure_to_salesforce"
  resource_group_name = data.terraform_remote_state.api_connections.outputs.resource_group_name
  deployment_mode     = "Incremental"
  template_body       = file("../../arm-templates/from-azure-to-salesforce.json")
  parameters = {
    "api_connections_location"       = data.terraform_remote_state.api_connections.outputs.resource_group_location
    "api_connections_resource_group" = data.terraform_remote_state.api_connections.outputs.resource_group_name
    "location"                       = azurerm_resource_group.rg.location
  }
}
