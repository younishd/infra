resource "tailscale_tailnet_key" "cluster" {
  reusable      = true
  ephemeral     = false
  preauthorized = true
  expiry        = 3600
  description   = "Cluster key"
  tags          = ["tag:cluster"]
}
