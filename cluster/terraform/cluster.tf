resource "hcloud_server" "control_plane" {
  count = var.count_control_plane

  name        = "master-${count.index}"
  datacenter  = var.datacenter
  server_type = var.control_plane_server_type
  image       = var.image
  ssh_keys    = [hcloud_ssh_key.default.id]

  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.control_plane_ipv4[count.index].id
    ipv6_enabled = false
  }

  network {
    network_id = hcloud_network.private.id
    ip         = cidrhost("10.0.0.0/16", count.index + 2)
  }

  depends_on = [
    hcloud_network.private,
    hcloud_primary_ip.control_plane_ipv4
  ]
}

resource "hcloud_server" "data_plane" {
  count = var.count_data_plane

  name        = "worker-${count.index}"
  datacenter  = var.datacenter
  server_type = var.date_plane_server_type
  image       = var.image
  ssh_keys    = [hcloud_ssh_key.default.id]

  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.data_plane_ipv4[count.index].id
    ipv6_enabled = false
  }

  network {
    network_id = hcloud_network.private.id
    ip         = cidrhost("10.0.0.0/16", count.index + var.count_control_plane + 2)
  }

  depends_on = [
    hcloud_network.private,
    hcloud_primary_ip.data_plane_ipv4
  ]
}

resource "hcloud_primary_ip" "control_plane_ipv4" {
  count = var.count_control_plane

  name          = "master-${count.index}-ipv4"
  datacenter    = var.datacenter
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = true
}

resource "hcloud_primary_ip" "data_plane_ipv4" {
  count = var.count_data_plane

  name          = "worker-${count.index}-ipv4"
  datacenter    = var.datacenter
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = true
}

resource "hcloud_network" "private" {
  name     = "network-0"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "private" {
  type         = "cloud"
  network_id   = hcloud_network.private.id
  network_zone = "eu-central"
  ip_range     = "10.0.0.0/16"
}
