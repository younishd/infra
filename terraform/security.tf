resource "hcloud_firewall" "ingress" {
  name = "ingress"

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0"]
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = ["0.0.0.0/0"]
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "443"
    source_ips = ["0.0.0.0/0"]
  }
  rule {
    direction  = "in"
    protocol   = "udp"
    port       = "41641"
    source_ips = ["0.0.0.0/0"]
  }
}

resource "hcloud_firewall_attachment" "ingress" {
  firewall_id = hcloud_firewall.ingress.id
  server_ids  = concat(hcloud_server.control_plane[*].id, hcloud_server.data_plane[*].id)
}

resource "hcloud_ssh_key" "default" {
  name       = "younishd@lovelace"
  public_key = file(var.ssh_key)
}
