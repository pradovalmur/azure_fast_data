# Define Azure provider
provider "azurerm" {
    skip_provider_registration = "true"
    features {}
}

# Create resource group
resource "azurerm_resource_group" "cm_dev" {
    name     = "chameleon-mountain-dev"
    location = var.location
}

# Create Azure EventHub Namespace
resource "azurerm_eventhub_namespace" "cm_dev_eventHub_namespace"{
    name                    = "eventhub-namespace-${var.random_number}"
    location                = azurerm_resource_group.cm_dev.location
    resource_group_name     = azurerm_resource_group.cm_dev.name
    sku                     = "Standard"
    capacity                = 1
    tags = {
        environment     = "Developement"
    }
}

# Create an Event Hub in the namespace
resource "azurerm_eventhub" "operations" {
  name                = "topic_operations"
  namespace_name      = azurerm_eventhub_namespace.cm_dev_eventHub_namespace.name
  resource_group_name = azurerm_eventhub_namespace.cm_dev_eventHub_namespace.resource_group_name
  partition_count     = 4 # Customize as needed
message_retention       =   1
}

# Create a Consumption Group for Databricks
resource "azurerm_eventhub_consumer_group" "cm-consumergroup-databricks" {
  name                = "cg-databricks-${var.random_number}"
  eventhub_name       = azurerm_eventhub.operations.name
  namespace_name      = azurerm_eventhub_namespace.cm_dev_eventHub_namespace.name
  resource_group_name = azurerm_eventhub_namespace.cm_dev_eventHub_namespace.resource_group_name
}

# Create an Azure Cosmos DB Core (SQL) account
resource "azurerm_cosmosdb_account" "cm-comsosdb" {
  name                = "cosmos-${var.random_number}"
  location            = azurerm_resource_group.cm_dev.location
  resource_group_name = azurerm_resource_group.cm_dev.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  enable_automatic_failover = false
  geo_location {
    location          = var.location
    failover_priority = 0
  }
   consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  depends_on = [
    azurerm_resource_group.cm_dev
  ]
}

# Create an Azure Databricks workspace
resource "azurerm_databricks_workspace" "cm-databricks-workspace" {
  name                = "databricks-${var.random_number}"
  location            = azurerm_resource_group.cm_dev.location
  resource_group_name = azurerm_resource_group.cm_dev.name
  sku                 = "standard"
 
}