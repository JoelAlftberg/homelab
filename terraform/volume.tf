locals {
  fcos_qemu_image = "https://download.fedoraproject.org/pub/fedora/linux/releases/${var.fedora_version}/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-${var.fedora_version}-1.7.x86_64.qcow2"
}

# Create volume from the URL

resource "libvirt_volume" "fcos_base" {
  name = "fedora-cloud-base.qcow2"
  pool = libvirt_pool.homelab_pool.name
  target = {
    format = {
      type = "qcow2"
    }
  }

  create = {
    content = {
      url = local.fcos_qemu_image
    }
  }
}
