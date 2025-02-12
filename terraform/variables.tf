variable "control_plane_server_type" {
  description = "Control plane server flavor"
  type        = string
  default     = "cax31"
}

variable "date_plane_server_type" {
  description = "Data plane server flavor"
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
  default     = 1
}

variable "subnet_cidr" {
  description = "Subnet IPv4 CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "datacenter" {
  description = "Datacenter identifier"
  type        = string
  default     = "fsn1-dc14"
}

variable "image" {
  description = "Server image"
  type        = string
  default     = "ubuntu-22.04"
}

variable "ssh_key" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "gandi_token" {
  description = "Gandi personal access token"
  type        = string
  sensitive   = true
}

variable "tailscale_oauth_client_id" {
  description = "Tailscale OAuth client ID"
  type        = string
  sensitive   = true
}

variable "tailscale_oauth_client_secret" {
  description = "Tailscale OAuth client secret"
  type        = string
  sensitive   = true
}

variable "random_hostnames" {
  description = "List of random hostnames to pick from"
  type        = list(string)
  default = [
    "bamboo-jungle",
    "birch-forest",
    "eroded-badlands",
    "frozen-river",
    "lukewarm-ocean",
    "mangrove-swamp",
    "savanna-plateau",
    "snowy-beach",
    "sunflower-plains",
    "windswept-hills"
  ]
}
