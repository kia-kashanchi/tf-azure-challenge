variable "location" {
  type        = string
  default     = "westeurope"
  description = "Azure region"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B2s"
  description = "VM size"
}

variable "public_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "SSH public key path"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Global tags"
}