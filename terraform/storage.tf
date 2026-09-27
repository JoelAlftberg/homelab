resource "libvirt_pool" "homelab_pool" {
  name = "${var.environment}-pool"
  type = "dir"

  target = {
    path = "/var/lib/libvirt/images/${var.environment}"
  }
}
