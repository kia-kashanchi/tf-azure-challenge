terraform {
  required_version = ">= 1.5.0"
  backend "azurerm" {
    resource_group_name  = "tfstate-dev"
    storage_account_name = "tfstatedev123"
    container_name       = "dev-tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

resource "azurerm_resource_group" "env" {
  name     = "dev-rg"
  location = var.location
  tags     = merge(var.tags, { Environment = "dev" })
}

module "vnet" {
  source              = "../../modules/vnet"
  resource_group_name = azurerm_resource_group.env.name
  location            = var.location
  vnet_name           = "dev-vnet"
  address_space       = ["10.1.0.0/16"]
  subnets = {
    "web" = {
      address_prefixes = ["10.1.1.0/24"]
      nsg_rules = [{
        name                       = "allow-ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }]
    }
  }
  tags = var.tags
}

module "vm" {
  source              = "../../modules/vm"
  resource_group_name = azurerm_resource_group.env.name
  location            = var.location
  vm_name             = "dev-vm"
  size                = var.vm_size
  public_key_path     = var.public_key_path
  subnet_id           = module.vnet.subnet_ids["web"]
  tags                = merge(var.tags, { Environment = "dev" })
}

module "blob" {
  source               = "../../modules/blob"
  resource_group_name  = azurerm_resource_group.env.name
  location             = var.location
  storage_account_name = "devstorage"
  container_name       = "dev-container"
  tags                 = merge(var.tags, { Environment = "dev" })
}