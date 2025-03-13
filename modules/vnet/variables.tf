variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "address_space" {
  description = "List of address spaces for the VNET"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "The name of the default subnet"
  type        = string
  default     = "default"
}

variable "subnet_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "default_tags" {
  description = "Default tags for resources"
  type        = map(string)
  default     = { type = "vnet" }
}