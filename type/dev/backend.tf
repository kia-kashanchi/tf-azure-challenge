terraform {
  backend "azurerm" {
    storage_account_name = "yourtfstateaccount"   # Replace with your Storage Account name
    container_name       = "tfstate"               # Name of the blob container
    key                  = "dev.terraform.tfstate" # Unique key (state file name) for this environment
  }
}