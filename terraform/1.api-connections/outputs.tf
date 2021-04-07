
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}

output "salesforce_link" {
  value = "${var.azure_portal_url}/#@${var.azuread_domain}/resource/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${azurerm_resource_group.rg.name}/providers/Microsoft.Web/connections/salesforce/edit"
}

output "office365_link" {
  value = "${var.azure_portal_url}/#@${var.azuread_domain}/resource/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${azurerm_resource_group.rg.name}/providers/Microsoft.Web/connections/office365/edit"
}