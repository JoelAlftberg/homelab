resource "libvirt_network" "homelab_net" {
  name      = "homelab-net"
  autostart = true

  forward = {
    mode = "nat"
  }

  domain = {
    name = "homelab.local"
  }

  ips = [
    {
      address = "10.22.1.1"
      netmask = "255.255.255.0"
      dhcp = {
        ranges = [
          {
            start = "10.22.1.2"
            end   = "10.22.1.254"
          }
        ]
      }
    }
  ]
}
