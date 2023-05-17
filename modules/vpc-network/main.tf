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
  name                    = "main-network"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"

  depends_on = [
    google_project_service.service
  ]
}

resource "google_compute_subnetwork" "main_subnetwork" {
  name          = "main-subnetwork"
  ip_cidr_range = "10.10.10.0/24"
  network       = google_compute_network.main_network.id
  region        = var.region

  secondary_ip_range = [
    {
      range_name    = "services"
      ip_cidr_range = "10.10.11.0/24"
    },
    {
      range_name    = "pods"
      ip_cidr_range = "10.1.0.0/20"
    }
  ]

  private_ip_google_access = true

}



