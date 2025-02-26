resource "local_file" "ssh_config" {
  content = templatefile("ssh_config.tftpl", {
    "hosts" : [
      for i, v in concat(hcloud_server.control_plane, hcloud_server.data_plane) : {
        name : v.name,
        public_ipv4 : hcloud_primary_ip.public[i].ip_address
      }
    ]
  })
  filename = "../ssh/hcloud.config"
}

resource "local_file" "inventory" {
  content = templatefile("inventory.tftpl", {
    "control_plane" : hcloud_server.control_plane[*].name,
    "data_plane" : hcloud_server.data_plane[*].name
  })
  filename = "../inventory/hcloud/main.yaml"
}

output "public" {
  value = hcloud_primary_ip.public[*].ip_address
}
