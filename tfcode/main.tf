terraform { 
  cloud { 
    
    organization = "${var.owner}-org" 

    workspaces { 
      name = "sql-database" 
    } 
  } 
}

provider "azurerm" {
  features {}
  subscription_id = var.subscriptionid
  resource_provider_registrations = "none"
}

resource "azurerm_resource_group" "example" {
  name     = "${var.owner}-resources"
  location = "Australia East"
}

resource "azurerm_mssql_server" "example" {
  name                         = "pcarey-sqlserver"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = var.adminlogin
  administrator_login_password = var.adminpwd
}

resource "azurerm_mssql_database" "example" {
  name         = "example-db"
  server_id    = azurerm_mssql_server.example.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

  tags = {
    owner = var.owner
  }
}

/*
resource "azurerm_mssql_database" "new-example" {
  name         = "new-db"
  server_id    = azurerm_mssql_server.example.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

  tags = {
    owner = var.owner
  }
}
*/
