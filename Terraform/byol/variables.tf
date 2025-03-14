variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

// Marketplace requires this variable name to be declared
variable "goog_cm_deployment_name" {
  description = "The name of the deployment and VM instance."
  type        = string
}

variable "zone" {
  description = "The zone for the solution to be deployed."
  type        = string
  default     = "us-central1-b"
}

variable "source_image" {
  description = "The image name for the disk for the VM instance."
  type        = string
  default     = "projects/fortigcp-project-001/global/images/fwb-763-byol-03102025-001-w-license"
}

variable "machine_type" {
  description = "The machine type to create, e.g. e2-small"
  type        = string
  default     = "n2-standard-4"
}

variable "boot_disk_type" {
  description = "The boot disk type for the VM instance."
  type        = string
  default     = "pd-ssd"
}

variable "boot_disk_size" {
  description = "The boot disk size for the VM instance in GBs"
  type        = string
  default     = "31"
}

variable "enable_tcp_22" {
  description = "Enable network traffic over port 22 for FortiWeb"
  type        = bool
  default     = true
}

variable "tcp_22_ip_source_ranges" {
  description = "A comma separated string of source IP ranges for accessing the VM instance over TCP port 22."
  type        = string
  nullable    = true
}

variable "enable_tcp_80" {
  description = "Enable network traffic over port 80 for FortiWeb"
  type        = bool
  default     = true
}

variable "tcp_80_ip_source_ranges" {
  description = "A comma separated string of source IP ranges for accessing the VM instance over HTTP port 80."
  type        = string
  nullable    = true
}

variable "enable_tcp_443" {
  description = "Enable network traffic over port 443 for FortiWeb"
  type        = bool
  default     = true
}

variable "tcp_443_ip_source_ranges" {
  description = "A comma separated string of source IP ranges for accessing the VM instance over HTTPS port 443."
  type        = string
  nullable    = true
}

variable "enable_tcp_8080" {
  description = "Enable network traffic over port 8080 for FortiWeb"
  type        = bool
  default     = true
}

variable "tcp_8080_ip_source_ranges" {
  description = "A comma separated string of source IP ranges for accessing the VM instance over TCP port 8080."
  type        = string
  nullable    = true
}

variable "enable_tcp_8443" {
  description = "Enable network traffic over port 8443 for FortiWeb"
  type        = bool
  default     = true
}

variable "tcp_8443_ip_source_ranges" {
  description = "A comma separated string of source IP ranges for accessing the VM instance over TCP port 8443."
  type        = string
  nullable    = true
}

variable "enable_ip_forward" {
  description = "Enable IP Forwarding"
  type        = bool
  default     = true
}

variable "networks" {
  description = "The network name to attach the VM instance."
  type        = list(string)
  default     = ["default"]
}

variable "sub_networks" {
  description = "The sub network name to attach the VM instance."
  type        = list(string)
  default     = ["default"]
}

variable "external_ips" {
  description = "The external IPs assigned to the VM for public access."
  type        = list(string)
  default     = ["EPHEMERAL"]
}

variable "use_license_file" {
  description = "Enable Meta License"
  type        = bool
  default     = false
}
variable "license_file" {
  description = "the path of FWB License or the content of License"
  type        = string
  default     = ""
}


variable "use_flex_license" {
  description = "Use FortiFlex License for FWB"
  type        = bool
  default     = false
}
variable "fortiflex_license" {
  description = "FortiFlex License Content"
  type        = string
  default     = ""
}

variable "enable_meta_user" {
  description = "Enable initial bootup using user data"
  type        = bool
  default     = false
}

variable "user_data_value" {
  description = "Enter the path of config file run at bootstrap"
  type        = string
  default     = ""
}
