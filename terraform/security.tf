resource "hcloud_firewall" "allow_in" {
  name = "allow-in"
  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_firewall" "deny_all" {
  name = "deny-all"
}

resource "hcloud_firewall_attachment" "allow_in" {
  firewall_id = hcloud_firewall.allow_in.id
  server_ids  = [hcloud_server.control_plane[0].id]
  depends_on  = [hcloud_server.control_plane[0]]
}

resource "hcloud_firewall_attachment" "deny_all" {
  firewall_id = hcloud_firewall.deny_all.id
  server_ids  = [for v in concat(slice(hcloud_server.control_plane, 1, length(hcloud_server.control_plane)), hcloud_server.data_plane) : v.id]
  depends_on  = [hcloud_server.control_plane, hcloud_server.data_plane]
}

resource "hcloud_ssh_key" "default" {
  name       = "younishd@lovelace"
  public_key = file("id_ed25519.pub")
}
