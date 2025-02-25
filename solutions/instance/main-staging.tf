resource "time_sleep" "wait_5_seconds" {
    create_duration = "5s"
}

##############################################################################

output "resource_group_id" {
    value       = "resource_group_id"
}

output "resource_group_name" {
    value       = resource_group_name
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