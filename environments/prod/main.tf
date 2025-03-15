terraform {
  required_version = ">= 1.5.0"
  backend "azurerm" {
    resource_group_name  = "tfstate-prod"
    storage_account_name = "tfstateprod456"
    container_name       = "prod-tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

resource "azurerm_resource_group" "env" {
  name     = "prod-rg"
  location = var.location
  tags     = merge(var.tags, { Environment = "prod" })
}

module "vnet" {
  source              = "../../modules/vnet"
  resource_group_name = azurerm_resource_group.env.name
  location            = var.location
  vnet_name           = "prod-vnet"
  address_space       = ["10.100.0.0/16"]
  enable_nsg          = true
  subnets = {
    "web" = {
      address_prefixes = ["10.100.1.0/24"]
      nsg_rules = [{
        name                       = "allow-http"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }]
    }
  }
  tags = merge(var.tags, { Critical = "true" })
}

module "vm" {
  source              = "../../modules/vm"
  resource_group_name = azurerm_resource_group.env.name
  location            = var.location
  vm_name             = "prod-vm"
  size                = var.vm_size
  public_key_path     = var.public_key_path
  subnet_id           = module.vnet.subnet_ids["web"]
  tags                = merge(var.tags, { Environment = "prod" })
}

module "blob" {
  source               = "../../modules/blob"
  resource_group_name  = azurerm_resource_group.env.name
  location             = var.location
  storage_account_name = "prodstorage"
  account_replication_type = "GRS"
  container_name       = "prod-container"
  tags                 = merge(var.tags, { Environment = "prod" })
}