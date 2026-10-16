terraform {
  required_version = ">= 1.0.0"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.9.9"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}
