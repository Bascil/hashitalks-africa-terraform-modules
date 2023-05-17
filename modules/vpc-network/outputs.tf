output "network" {
  description = "A reference (self_link) to the VPC network"
  value       = google_compute_network.main_network.self_link
}

output "subnetwork" {
  description = "A reference (self_link) to the subnetwork"
  value       = google_compute_subnetwork.main_subnetwork.self_link
}
