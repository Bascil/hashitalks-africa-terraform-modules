# Enable APIs
resource "google_project_service" "trigger_apis" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "cloudkms.googleapis.com"
  ])

  service            = each.key
  project            = var.project
  disable_on_destroy = false
}

# create a keyring
resource "google_kms_key_ring" "key_ring" {
  name     = "${var.branch}-${var.keyring_name}"
  location = var.region
}

# in order to use the keyring, we have to create a key inside this key ring
resource "google_kms_crypto_key" "key" {
  name            = "${var.branch}-${var.key_name}"
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = var.rotation_period

  version_template {
    algorithm = var.algorithm
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_service_account" "cloud_kms_sa" {
  account_id   = "cloud-kms-sa"
  display_name = "Service Account For Cloud KMS"
}

# we have to give permissions to a google identity who can use this key or encryption and decryption
resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    "serviceAccount:${google_service_account.cloud_kms_sa.email}"
  ]
}


