variable "control_plane_server_type" {
  description = "Control plane server type"
  type        = string
  default     = "cax21"
}

variable "date_plane_server_type" {
  description = "Data plane server type"
  type        = string
  default     = "cax31"
}

variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}
