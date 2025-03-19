terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.23.0"
    }
  }
}

provider "azurerm" {

   client_id = "d4d3d665-7a3b-42eb-b893-f033a87d5d07"
    tenant_id = "a1774e62-b345-4157-bad9-e77976dab502"
    subscription_id = "2808149b-5dd0-4ca8-8a0f-2b8ec273047b"
    
    
    features {

    }

}

resource "azurerm_resource_group" "example" {
  name     = "sgrs_Loadbalancer"
  location = "West Europe"
}

resource "azurerm_public_ip" "example" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "example" {
  name                = "TestLoadBalancer"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}
