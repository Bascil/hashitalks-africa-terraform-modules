# Enable APIs
resource "google_project_service" "trigger_apis" {
  service            = "secretmanager.googleapis.com"
  project            = var.project
  disable_on_destroy = false
}

resource "google_secret_manager_secret" "secret" {
  for_each  = var.secrets
  secret_id = each.value.secret_id

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "version" {
  for_each    = var.secrets
  secret      = google_secret_manager_secret.secret[each.key].id
  secret_data = each.value.secret_data
}
