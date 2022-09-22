locals {
    rg_name = "rg-test1"
}

terraform {
    backend "azurerm" {
        resource_group_name  = "rg-test1"
        storage_account_name = "mcruzorgtfstate"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

provider "azurerm" {
    features {

    }
}

resource "azurerm_resource_group" "rg-test1" {
    name = "rg-test1"
    location = "northeurope"
}

resource "azurerm_container_group" "aci-weatherapi" {
  name                = "aci-weatherapi"
  location            = azurerm_resource_group.rg-test1.location
  resource_group_name = azurerm_resource_group.rg-test1.name
  ip_address_type     = "Public"
  dns_name_label      = "mcruzorg-weatherapi"
  os_type             = "Linux"

  container {
    name   = "weatherapi2"
    image  = "mczandre/weatherapi:64"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "dev"
  }
}

output "aci_fqdn" {
  description = "FQDN of the ACI"
  value = azurerm_container_group.aci-weatherapi.fqdn
}
