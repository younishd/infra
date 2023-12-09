terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.42"
    }
    gandi = {
      version = "~> 2.0"
      source  = "go-gandi/gandi"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "gandi" {
  key = var.gandi_token
}
