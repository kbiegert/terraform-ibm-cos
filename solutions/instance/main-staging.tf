# read ssh keys available in the cloud under this account - don't care
# about the keys just want to force the terraform to login to the cloud.
data "ibm_is_ssh_keys" "mykeys" {
}

locals {
    howmanykeys = length(data.ibm_is_ssh_keys.mykeys.keys)
}
output "mykeys" {
    value = "There are ${local.howmanykeys} ssh keys defined by the account owning this api key."
}

resource "time_sleep" "wait_3_seconds" {
    create_duration = "3s"
}

##############################################################################

output "resource_group_id" {
    value       = "resource_group_id"
}

output "resource_group_name" {
    value       = "resource_group_name"
}

output "cos_instance_id" {
    value       = "cos_instance_id"
}

output "cos_instance_guid" {
    value       = "cos_instance_guid"
}

output "resource_keys" {
    value       = "resource_keys"
    sensitive   = true
}
output "service_credential_secrets" {
    value       = "service_credential_secrets"
}

output "service_credential_secret_groups" {
    value       = "service_credential_secret_groups"
}
output "cos_instance_name" {
    value       = "cos_instance_name"
}