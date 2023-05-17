locals {
  service_account_roles = concat([], [
    "roles/storage.objectViewer", 
    "roles/serviceusage.serviceUsageAdmin"
  ])
}

# create a zonal cluster 
resource "google_container_cluster" "cluster" {
  name     = "${var.branch}-cluster"
  location = var.zone

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network_main
  subnetwork = var.subnetwork_private

  networking_mode           = "VPC_NATIVE"
  default_max_pods_per_node = 32

  vertical_pod_autoscaling {
    enabled = true
  }

  addons_config {
    #  set up HTTP load balancers for services in a cluster - enabled by default
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      # increases or decreases the number of replica pods - enabled by default
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project}.svc.id.goog"
  }

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  timeouts {
    create = "2h"
    delete = "60m"
  }

}

resource "google_container_node_pool" "preemptible" {
  name    = "preemptible"
  cluster = google_container_cluster.cluster.id

  initial_node_count = 1
  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = "n2d-standard-2"
    preemptible  = true

    service_account = google_service_account.workload_identity_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      type = "Preemptible"
    }
  }

}

resource "google_service_account" "workload_identity_sa" {
  account_id   = "workload-identity-sa"
  display_name = "Service Account For Workload Identity"
}

resource "google_project_iam_member" "workload_identity_roles" {
  for_each = toset(local.service_account_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.workload_identity_sa.email}"
}

resource "google_project_iam_member" "workload_identity_user" {
  project = var.project
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.project}.svc.id.goog[/workload-identity-user]"
}