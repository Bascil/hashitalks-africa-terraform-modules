resource "google_secret_manager_secret" "secret" {
  for_each  = var.secrets.values
  secret_id = each.value.secret_id

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "version" {
  for_each    = var.secrets.values
  secret      = google_secret_manager_secret.secret[each.key].id
  secret_data = each.value.secret_data
}
