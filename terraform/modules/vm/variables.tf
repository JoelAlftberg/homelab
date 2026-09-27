# modules/vm/variables.tf

variable "ssh_public_key" {
    type = string
    description = "The public SSH key passed down from root config"
}

# modules/vm/variables.tf

variable "environment" {
  type = string
}

variable "role" {
  type = string
}

variable "node_count" {
  type = number
}

variable "memory" {
  type    = number
  default = 4096
}

variable "vcpu" {
  type    = number
  default = 2
}

variable "pool_name" {
  type = string
}

variable "network_name" {
  type = string
}

variable "backing_store_path" {
  type = string
}

variable "vm_ips" {
  type = list(string)
}

variable "gateway_ip" {
  type = string
}

