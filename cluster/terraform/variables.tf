variable "control_plane_server_type" {
  description = "Control plane server type"
  type        = string
  default     = "cx31"
}

variable "date_plane_server_type" {
  description = "Data plane server type"
  type        = string
  default     = "cpx21"
}

variable "count_control_plane" {
  description = "Number of control plane servers"
  type        = number
  default     = 1
}

variable "count_data_plane" {
  description = "Number of data plane servers"
  type        = number
  default     = 1
}

variable "datacenter" {
  description = "Datacenter identifier"
  type        = string
  default     = "hel1-dc2"
}

variable "image" {
  description = "Server image"
  type        = string
  default     = "ubuntu-22.04"
}

variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}
