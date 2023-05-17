resource "google_project_service" "service" {
  for_each = toset([
    "compute.googleapis.com",
    "container.googleapis.com",
    "vpcaccess.googleapis.com",
    "servicenetworking.googleapis.com"
  ])
  service            = each.key
  project            = var.project
  disable_on_destroy = false
}

resource "google_compute_network" "main_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"

  depends_on = [
    google_project_service.service
  ]
}

resource "google_compute_subnetwork" "main_subnetwork" {
  name          = var.vpc_subnet
  ip_cidr_range = var.vpc_cidr
  network       = google_compute_network.main_network.id
  region        = var.region

  secondary_ip_range = var.ip_ranges
  private_ip_google_access = true

}



