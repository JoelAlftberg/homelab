variable "environment" {
  type    = string
  default = "staging"
}

variable "control_plane_count" {
  type    = number
  default = 1
}

variable "cluster_worker_count" {
  type    = number
  default = 2
}

variable "fedora_version" {
  type    = string
  default = "44"
}

