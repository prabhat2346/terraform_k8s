// Indicates a module has run to completion
/*
output "complete" {
  value       = join(" ", helm_release.clusterissuerprod.*.id)
  description = "Indicates a module has run to completion"
}

output "password" {
  value       = random_string.password.result
  description = "Password for SP"
}
*/

output "tenant" {
  value       = var.az_tenant_id
  description = "Tenant for SP"
}

output "subscriptionID" {
  value = var.az_subscription_id
}

output "tenantID" {
  value = var.az_tenant_id
}

output "resourceGroupName" {
  value = "${var.base_name}dnsRg1"
}

output "hostedZone" {
  value = local.hostedZone
}






