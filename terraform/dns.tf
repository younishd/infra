data "gandi_domain" "zenshift_io" {
  name = "zenshift.io"
}

resource "gandi_livedns_record" "zenshift_io" {
  zone = data.gandi_domain.zenshift_io.id
  name = "@"
  type = "A"
  ttl  = 3600
  values = [
    hcloud_primary_ip.public[0].ip_address
  ]
}

resource "gandi_livedns_record" "zenshift_io_subdomains" {
  zone = data.gandi_domain.zenshift_io.id
  name = "*"
  type = "A"
  ttl  = 3600
  values = [
    hcloud_primary_ip.public[0].ip_address
  ]
}
