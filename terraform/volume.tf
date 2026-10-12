locals {
  ubuntu_qemu_image = "https://cloud-images.ubuntu.com/${var.ubuntu_release}/current/${var.ubuntu_release}-server-cloudimg-amd64.img"
}

# Create volume from the URL

resource "libvirt_volume" "ubuntu_base" {
  name = "ubuntu-cloud-base.qcow2"
  pool = libvirt_pool.homelab_pool.name
  target = {
    format = {
      type = "qcow2"
    }
  }

  create = {
    content = {
      url = local.ubuntu_qemu_image
    }
  }
}
