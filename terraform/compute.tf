# Control Planes
module "control_plane" {
  source         = "./modules/vm"
  environment    = var.environment
  role           = "k8s-control-plane"
  node_count     = var.control_plane_count
  memory         = 4096
  vcpu           = 2
  pool_name      = libvirt_pool.homelab_pool.name
  network_name   = libvirt_network.homelab_net.name
  ssh_public_key = tls_private_key.ssh.public_key_openssh
  backing_store_path = libvirt_volume.fcos_base.path
  vm_ips = ["10.22.1.10"]
  gateway_ip = "10.22.1.1"
}

module "worker_nodes" {
  source         = "./modules/vm"
  environment    = var.environment
  role           = "k8s-worker"
  node_count     = var.cluster_worker_count
  memory         = 4096
  vcpu           = 2
  pool_name      = libvirt_pool.homelab_pool.name
  network_name   = libvirt_network.homelab_net.name
  ssh_public_key = tls_private_key.ssh.public_key_openssh
  backing_store_path = libvirt_volume.fcos_base.path
  vm_ips = ["10.22.1.11", "10.22.1.12"]
  gateway_ip = "10.22.1.1"
}


module "services" {
  source = "./modules/vm"
  environment = "prod"
  role ="services"
  node_count = 1
  memory = 8192
  vcpu = 4
  pool_name = libvirt_pool.homelab_pool.name
  network_name = libvirt_network.homelab_net.name
  ssh_public_key = tls_private_key.ssh.public_key_openssh
  backing_store_path = libvirt_volume.fcos_base.path
  vm_ips = ["10.22.1.100"]
  gateway_ip = "10.22.1.1"
}

