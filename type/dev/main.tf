provider "azurerm" {
  features {}

  # Optional: If not using environment variables for subscription and tenant, uncomment and set these:
  # subscription_id = var.subscription_id
  # tenant_id       = var.tenant_id
}

# Create Resource Group
resource "azurerm_resource_group" "dev" {
  name     = "rg-dev-eastus"
  location = var.location
  tags     = {
    environment = "development"
    region      = "eastus"
  }
}

# Deploy VNET module
module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = "vnet-dev-eastus"
  location            = var.location
  resource_group_name = azurerm_resource_group.dev.name
  address_space       = ["10.1.0.0/16"]
}

# Deploy Storage module
module "storage" {
  source                   = "../../modules/storage"
  resource_group_name      = azurerm_resource_group.dev.name
  location                 = var.location
  storage_account_name     = "stdeveastus123"  # Must be globally unique
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "development"
    region      = "eastus"
  }
}

# Deploy VM module (Using SSH key authentication)
module "vm" {
  source              = "../../modules/vm"
  resource_group_name = azurerm_resource_group.dev.name
  location            = var.location
  subnet_id           = module.vnet.subnet_id
  nic_name            = "nic-dev-eastus"
  vm_name             = "vm-dev-eastus"
  vm_size             = "Standard_B1s"
  os_disk_name        = "osdisk-vm-dev-eastus"
  admin_username      = var.admin_username
  admin_ssh_public_key= var.admin_ssh_public_key
  tags = {
    environment = "development"
    region      = "eastus"
  }
}