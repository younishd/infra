resource "random_shuffle" "hostnames" {
  input        = var.random_hostnames
  result_count = var.count_control_plane + var.count_data_plane
}

resource "hcloud_server" "control_plane" {
  count = var.count_control_plane

  name        = random_shuffle.hostnames.result[count.index]
  datacenter  = var.datacenter
  server_type = var.control_plane_server_type
  image       = var.image
  ssh_keys    = [hcloud_ssh_key.default.id]

  user_data = templatefile("cloud-init.tftpl", {
    auth_key : tailscale_tailnet_key.cluster.key
  })

  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.public[count.index].id
    ipv6_enabled = false
  }

  network {
    network_id = hcloud_network.private.id
    ip         = cidrhost(var.subnet_cidr, count.index + 2)
  }

  lifecycle {
    ignore_changes = [
      user_data
    ]
  }

  depends_on = [
    hcloud_network.private,
    hcloud_primary_ip.public
  ]
}

resource "hcloud_server" "data_plane" {
  count = var.count_data_plane

  name        = random_shuffle.hostnames.result[count.index + var.count_control_plane]
  datacenter  = var.datacenter
  server_type = var.date_plane_server_type
  image       = var.image
  ssh_keys    = [hcloud_ssh_key.default.id]

  user_data = templatefile("cloud-init.tftpl", {
    auth_key : tailscale_tailnet_key.cluster.key
  })

  public_net {
    ipv4_enabled = true
    ipv4         = hcloud_primary_ip.public[count.index + var.count_control_plane].id
    ipv6_enabled = false
  }

  network {
    network_id = hcloud_network.private.id
    ip         = cidrhost(var.subnet_cidr, count.index + var.count_control_plane + 2)
  }

  lifecycle {
    ignore_changes = [
      user_data
    ]
  }

  depends_on = [
    hcloud_network.private
  ]
}

resource "hcloud_primary_ip" "public" {
  count = var.count_control_plane + var.count_data_plane

  name          = "${random_shuffle.hostnames.result[count.index]}-public-ipv4"
  datacenter    = var.datacenter
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = true
}

resource "hcloud_network" "private" {
  name     = "private"
  ip_range = var.subnet_cidr
}

resource "hcloud_network_subnet" "private" {
  type         = "cloud"
  network_id   = hcloud_network.private.id
  network_zone = "eu-central"
  ip_range     = hcloud_network.private.ip_range
}
