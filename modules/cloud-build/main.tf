
# Enable APIs
resource "google_project_service" "trigger_apis" {
  service            = "cloudbuild.googleapis.com"
  project            = var.project
  disable_on_destroy = false
}

resource "google_cloudbuild_trigger" "infra-trigger" {
  project     = var.project
  name        = "${var.branch}-${var.name}-infra-trigger"
  description = "${title(var.name)} Trigger"

  trigger_template {
    # use tags on master branch
    branch_name = var.branch != "master" ? "^${var.branch}$" : null
    tag_name    = var.branch == "master" ? ".*" : null

    repo_name = "github_hashitalks-africa-terraform-live"
  }

  filename = "${var.branch}.cloudbuild.yaml"
}

resource "google_cloudbuild_trigger" "k8s-trigger" {
  project     = var.project
  name        = "${var.branch}-${var.name}-k8s-trigger"
  description = "${title(var.name)} Trigger"

  trigger_template {
    # use tags on master branch
    branch_name = var.branch != "master" ? "^${var.branch}$" : null
    tag_name    = var.branch == "master" ? ".*" : null

    repo_name = "github_hashitalks-africa-kubernetes-manifests"
  }

  filename = "${var.branch}.cloudbuild.yaml"
}

resource "google_cloudbuild_trigger" "demo-trigger" {
  project     = var.project
  name        = "${var.branch}-${var.name}-demo-trigger"
  description = "${title(var.name)} Trigger"

  trigger_template {
    # use tags on master branch
    branch_name = var.branch != "master" ? "^${var.branch}$" : null
    tag_name    = var.branch == "master" ? ".*" : null

    repo_name = "github_hashitalks-africa-nest-demo-microservice"
  }

  filename = "${var.branch}.cloudbuild.yaml"
}


