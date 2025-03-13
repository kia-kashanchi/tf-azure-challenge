variable "location" {
  description = "Azure region for the dev environment"
  type        = string
  default     = "eastus"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "adminuser"
}

variable "admin_ssh_public_key" {
  description = "SSH public key for the VM"
  type        = string
  default     = file("~/.ssh/id_rsa.pub")  # Reads your SSH public key from a local file
}

# Optional: If you wish to explicitly pass subscription and tenant information:
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}