resource "libvirt_volume" "os_disk" {
  count = var.node_count
  name  = "${var.environment}-${var.role}-${format("%02d", count.index + 1)}-disk.qcow2"
  pool  = var.pool_name

  target = {
    format = {
      type = "qcow2"
    }
  }

  capacity      = 20
  capacity_unit = "G"

  backing_store = {
    path = var.backing_store_path
    format = {
      type = "qcow2"
    }
  }
}

resource "libvirt_volume" "data_disk" {
  count = var.role == "services" ? 1 : 0
  name = "${var.environment}-${var.role}-data.qcow2"
  pool = var.pool_name

  capacity = 50
  capacity_unit = "G"
  target = {
    format = {
      type = "qcow2"
    }
  }

}

resource "libvirt_cloudinit_disk" "init" {
    count = var.node_count
    name = "${var.environment}-${var.role}-${format("%02d", count.index + 1)}"
    user_data = templatefile("${path.module}/templates/cloud-init.yaml.tftpl", { ssh_public_key = var.ssh_public_key})
    network_config = templatefile("${path.module}/templates/network-config.yaml.tftpl", {vm_ip = var.vm_ips[count.index], gateway_ip = var.gateway_ip}) 

    meta_data = yamlencode({
        instance_id = "${var.environment}-${var.role}-${format("%02d", count.index + 1)}"
        local-hostname = "${var.environment}-${var.role}-${format("%02d", count.index + 1)}"
    })
}

resource "libvirt_volume" "cloudinit" {
  count = var.node_count
  name    = "${var.environment}-${var.role}-${format("%02d", count.index + 1)}-cloudinit.iso"
  pool = "default"

  create = {
    content = {
      url = libvirt_cloudinit_disk.init[count.index].path
    }
  }
}

resource "libvirt_domain" "vm" {
  count  = var.node_count
  name    = "${var.environment}-${var.role}-${format("%02d", count.index + 1)}"
  memory = var.memory
  memory_unit = "MiB"
  vcpu   = 2
  type   = "kvm"    
  running = true

  features  = {
    acpi = true
  }
  os = {
    type         = "hvm"
    type_arch    = "x86_64"
    type_machine = "q35"
    boot_devices = [{ dev = "hd" } ]
  }

  devices = {
    disks = concat(
      [
      {
        source = {
          volume = {
            pool   = var.pool_name 
            volume = libvirt_volume.os_disk[count.index].name
          }
        }
        target = {
          dev = "vda"
          bus = "virtio"
        }
        driver = {
          name = "qemu"
          type = "qcow2"
        }
      }
    ],
    [
      for disk in libvirt_volume.data_disk : {
        source = {
          volume = {
            pool = var.pool_name
            volume = disk.name
          }
        }
        target = {
          dev = "vdb"
          bus = "virtio"
        }
        driver = {
          name = "qemu"
          type = "qcow2"
        }
      }
    ],
    [
      {
        device ="cdrom"
        source = {
          volume = {
            volume = libvirt_volume.cloudinit[count.index].name
            pool = "default"
            }  
          }
        target = {
          dev = "sdb"
          bus = "sata"
        }
        driver = {
          name = "qemu"
          type = "raw"
        }
      }
    ]
  )
    interfaces = [
      {
        source = {
          network = {
            network = var.network_name
          }
        }
        model = {
          type = "virtio"
        }
      }
    ]
    serials = [
      {
        type = "pty"
        target = {
          type = "isa-serial"
          port = 0
        }
      }
    ]
    consoles = [
      {
        type = "pty"
        target = {
          type = "serial"
          port = 0
        }
      }
    ]
  }
}
