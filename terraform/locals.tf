locals {
  gateway = cidrhost(var.network_cidr, 1)
  prefix = tonumber(split("/", var.network_cidr)[1])

  control_plane_ips = [for i in range(var.control_plane_count) : cidrhost(var.network_cidr, 10 + i)]
  cluster_worker_ips = [for i in range(var.cluster_worker_count) : cidrhost(var.network_cidr, 20 + i)]
  service_host_ip = [cidrhost(var.network_cidr, 100)]
  utility_host_ip = [cidrhost(var.network_cidr, 101)]
}
