variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the VM NIC will be created"
  type        = string
}

variable "nic_name" {
  description = "The name of the network interface"
  type        = string
}

variable "vm_name" {
  description = "The name of the Virtual Machine"
  type        = string
}

variable "vm_size" {
  description = "The size of the Virtual Machine"
  type        = string
}

variable "os_disk_name" {
  description = "The name of the OS disk"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_ssh_public_key" {
  description = "SSH public key for the VM"
  type        = string
}

variable "image_publisher" {
  description = "The image publisher"
  type        = string
}

variable "image_offer" {
  description = "The image offer"
  type        = string
}

variable "image_sku" {
  description = "The image SKU"
  type        = string
}

variable "image_version" {
  description = "The image version"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to resources"
  type        = map(string)
}