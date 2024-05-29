output "workspace_name" {
  value = azurerm_databricks_workspace.tf_databricks.name
}

output "workspace_url" {
  value = azurerm_databricks_workspace.tf_databricks.workspace_url
}

output "workspace_id" {
  value = azurerm_databricks_workspace.tf_databricks.id
}