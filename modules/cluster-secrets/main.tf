resource "kubernetes_secret" "cluster_secret" {
  metadata {
    name      = "${var.secret_name}-cluster-secret"
    namespace = var.branch
    labels    = {}
  }

  data = var.secrets
}