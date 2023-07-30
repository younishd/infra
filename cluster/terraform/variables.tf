variable "control_plane_server_type" {
  description = "Control plane server type"
  type        = string
  default     = "cax41"
}

variable "date_plane_server_type" {
  description = "Data plane server type"
  type        = string
  default     = "cax31"
}

variable "count_control_plane" {
  description = "Number of control plane servers"
  type        = number
  default     = 1
}

variable "count_data_plane" {
  description = "Number of data plane servers"
  type        = number
  default     = 0
}

variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}
