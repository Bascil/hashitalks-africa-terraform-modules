data "google_client_config" "provider" {}

provider "kubernetes" {
  host  = "https://${var.cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    var.cluster.master_auth[0].cluster_ca_certificate,
  )
}
