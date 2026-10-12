variable "environment" {
  type    = string
  default = "lab"
}

variable "internal_domain" {
  type = string
  default = "lab.alftberg.net"
}

variable "control_plane_count" {
  type    = number
  default = 1
}

variable "cluster_worker_count" {
  type    = number
  default = 2
}

variable "ubuntu_release" {
  type    = string
  default = "noble"
}

variable "network_cidr" {
  default = "10.22.1.0/24"
}
