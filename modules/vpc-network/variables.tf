variable "project" {
  description = "The region for subnetworks in the network"
  type        = string
}

variable "region" {
  description = "The region for subnetworks in the network"
  type        = string
}

variable vpc_name {
  description = "The name of vpc network"
  type        = string
}

variable vpc_subnet {
  description = "The name of vpc sub network"
  type        = string
}

variable vpc_cidr {}
variable ip_ranges {}
