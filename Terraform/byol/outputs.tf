locals {
  network_interface = google_compute_instance.fortiweb.network_interface[0]
  instance_id = google_compute_instance.fortiweb.instance_id
}

output "admin_user" {
  description = "Username for the admin user"
  value       = "admin"
}

output "admin_password" {
  description = "Password for the admin user"
  value       = local.instance_id
  sensitive   = true
}

output "has_external_ip" {
  description = "Flag to indicate if the FortiWeb machine has an external IP"
  value       = length(compact(local.network_interface.access_config[*].nat_ip)) > 0 ? true : false
}

output "instance_machine_type" {
  description = "Machine type for the FortiWeb compute instance"
  value       = var.machine_type
}

output "instance_nat_ip" {
  description = "Machine type for the FortiWeb compute instance"
  value       = length(local.network_interface.access_config) > 0 ? local.network_interface.access_config[0].nat_ip : null
}

output "instance_network" {
  description = "Network for the FortiWeb compute instance"
  value       = local.network_interface.network
}

output "instance_self_link" {
  description = "Self-link for the FortiWeb compute instance"
  value       = google_compute_instance.fortiweb.self_link
}

output "instance_zone" {
  description = "Zone for the FortiWeb compute instance"
  value       = var.zone
}
