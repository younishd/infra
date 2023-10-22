resource "local_file" "ssh_config" {
  content = templatefile("ssh_config.tftpl", {
    "jumphost" : {
      name : hcloud_server.control_plane[0].name,
      public : hcloud_primary_ip.public[0].ip_address
    },
    "hosts" : [
      for v in concat(slice(hcloud_server.control_plane, 1, length(hcloud_server.control_plane)), hcloud_server.data_plane) : {
        name : v.name,
        private : tolist(v.network)[0].ip
      }
    ]
  })
  filename = "../ssh/hcloud.config"
}

resource "local_file" "inventory" {
  content = templatefile("inventory.tftpl", {
    "control_plane" : [
      for v in hcloud_server.control_plane : {
        name : v.name,
        private_ipv4 : tolist(v.network)[0].ip
      }
    ],
    "data_plane" : [
      for v in hcloud_server.data_plane : {
        name : v.name,
        private_ipv4 : tolist(v.network)[0].ip
      }
    ]
  })
  filename = "../inventory/hcloud/main.yaml"
}

output "public" {
  value = hcloud_primary_ip.public[0].ip_address
}
