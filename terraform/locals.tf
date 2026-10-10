locals {
  gateway = cirdhost(var.ntwork_cidr, 1)
  prefix = split("/", var.network_cidr)

  control_plane_ips = [for i in range(var.control_plane_count) : cidrhost(var.network_cidr, 10 + i)]
  cluster_worker_ips = [for i in range(var.cluster_worker_count) : cidrhost(var.network_cidr, 20 + i)]
  service_node_ip = [cidrhost(var.network_cidr, 100)]
}
