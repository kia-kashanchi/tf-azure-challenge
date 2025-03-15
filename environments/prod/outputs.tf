output "vm_public_ip" {
  value = module.vm.public_ip
}

output "storage_account_name" {
  value = module.blob.storage_account_name
}