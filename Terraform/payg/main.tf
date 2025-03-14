provider "google" {
  project = var.project_id
}

locals {
  image_name = element(split("/",var.source_image), 4)

  network_interfaces = [ for i, n in var.networks : {
    network     = n,
    subnetwork  = length(var.sub_networks) > i ? element(var.sub_networks, i) : null
    external_ip = length(var.external_ips) > i ? element(var.external_ips, i) : "NONE"
    }
  ]

  tcp_22_ip_source_ranges_map = var.enable_tcp_22 ? {
    "22" = split(",", var.tcp_22_ip_source_ranges)
  } : {}

  tcp_80_ip_source_ranges_map = var.enable_tcp_80 ? {
    "80" = split(",", var.tcp_80_ip_source_ranges)
  } : {}

  tcp_443_ip_source_ranges_map = var.enable_tcp_443 ? {
    "443" = split(",", var.tcp_443_ip_source_ranges)
  } : {}

  tcp_8080_ip_source_ranges_map = var.enable_tcp_8080 ? {
    "8080" = split(",", var.tcp_8080_ip_source_ranges)
  } : {}

  tcp_8443_ip_source_ranges_map = var.enable_tcp_8443 ? {
    "8443" = split(",", var.tcp_8443_ip_source_ranges)
  } : {}

  ip_source_ranges_map = merge(local.tcp_22_ip_source_ranges_map, local.tcp_80_ip_source_ranges_map, local.tcp_443_ip_source_ranges_map, local.tcp_8443_ip_source_ranges_map, local.tcp_8080_ip_source_ranges_map)
}

#Instance
resource "google_compute_instance" "fortiweb" {
  name         = var.goog_cm_deployment_name
  machine_type = var.machine_type
  zone         = var.zone
  can_ip_forward = var.enable_ip_forward

  metadata = {
    "user-data"            = var.enable_meta_user ? var.user_data_value: ""
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    INSTANCE_ID=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/id)
    gcloud compute instances add-metadata $(hostname) \
      --zone $(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/zone | awk -F/ '{print $NF}') \
      --metadata fortiweb_user_password=$INSTANCE_ID
  EOT

  boot_disk {
    initialize_params {
      size  = var.boot_disk_size
      type  = var.boot_disk_type
      image = var.source_image
    }
  }

  dynamic "network_interface" {
    for_each = local.network_interfaces
    content {
      network = network_interface.value.network
      subnetwork = network_interface.value.subnetwork

      dynamic "access_config" {
        for_each = network_interface.value.external_ip == "NONE" ? [] : [1]
        content {
          nat_ip = network_interface.value.external_ip == "EPHEMERAL" ? null : network_interface.value.external_ip
        }
      }
    }
  }

  tags = var.tcp_22_ip_source_ranges != "" || var.tcp_80_ip_source_ranges != "" || var.tcp_443_ip_source_ranges != "" || var.tcp_8443_ip_source_ranges != "" || var.tcp_8080_ip_source_ranges != "" ? ["${var.goog_cm_deployment_name}-deployment"] : []
  service_account {
    scopes = [
      "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
    ]
  }
}

#Network
resource "google_compute_firewall" "tcp_policy" {
  for_each = local.ip_source_ranges_map
  project  = var.project_id
  name     = "${var.goog_cm_deployment_name}-tcp-${each.key}"
  network  = element(var.networks, 0)

  allow {
    protocol = "tcp"
    ports    = [each.key]
  }

  source_ranges = each.value
  target_tags   = ["${var.goog_cm_deployment_name}-deployment"]
}
