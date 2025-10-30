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
    tailscale = {
      source  = "tailscale/tailscale"
      version = "~> 0.24"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "gandi" {
  key = var.gandi_token
}

provider "tailscale" {
  oauth_client_id     = var.tailscale_oauth_client_id
  oauth_client_secret = var.tailscale_oauth_client_secret
}

provider "random" {
}
