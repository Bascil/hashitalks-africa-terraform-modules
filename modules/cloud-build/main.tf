
# Enable APIs
resource "google_project_service" "trigger_apis" {
  service            = "cloudbuild.googleapis.com"
  project            = var.project
  disable_on_destroy = false
}

resource "google_cloudbuild_trigger" "trigger" {
  project     = var.project
  name        = "${var.branch}-${var.name}-trigger"
  description = "${title(var.name)} Trigger"

  trigger_template {
    # use tags on master branch
    branch_name = var.branch != "master" ? "^${var.branch}$" : null
    tag_name    = var.branch == "master" ? ".*" : null

    repo_name = var.repo
  }

  filename = "${var.branch}.cloudbuild.yaml"
}
