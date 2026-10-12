resource "libvirt_network" "homelab_net" {
  name      = "homelab-net"
  autostart = true

  forward = {
    mode = "nat"
  }

  domain = {
    name = var.internal_domain
  }

  ips = [
    {
      address = local.gateway
      netmask = cidrnetmask(var.network_cidr)
      dhcp = {
        ranges = [
          {
            start = cidrhost(var.network_cidr, 200)
            end   = cidrhost(var.network_cidr, 250)
          }
        ]
      }
    }
  ]
}
