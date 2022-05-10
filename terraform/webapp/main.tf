provider "azurerm" {
  version         = "=3.4.0"
  tenant_id       = "7cd4df23-8549-4990-a42f-466ae042efb2"
  subscription_id = "dbd83e64-1091-4252-b081-fd0a0aea47fc"
  client_id       = "57031495-1d8b-4617-87ca-4cabcc63f0cc"
  client_secret   = "yV_8Q~wB7Ajalt0Wn2M0CpYDRV_7gWyGcjRChb28"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "var.RG"
  location = "var.location"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "siddotnettestasp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "as" {
  name                = "siddotnettestas"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}