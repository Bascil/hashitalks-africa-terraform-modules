variable "project" {
  type = string
  description = "Project ID"
}

variable "network_main" {
  type = string
  description = "Main network (google_compute_network.main.self_link)"
}

variable "subnetwork_private" {
  type = string
  description = "Private subnetwork (google_compute_subnetwork.private.self_link)"
}

variable "branch" {
  type = string
  description = "Branch enviroment is running on"
}

variable "zone" {
  type = string
  description = "Cluster zone"
  default = "us-central1-a"
}

variable "region" {
  type = string
  description = "Cluster zone"
  default = "us-central1-a"
}