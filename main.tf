resource "google_artifact_registry_repository" "artifact-repo" {
  count         = var.no_of_repos
  repository_id = var.name_of_repos[count.index]
  provider      = google-beta
  project       = var.project_id
  location      = var.location
  description   = var.description[count.index] != null ? var.description[count.index] : "testing"
  kms_key_name  = var.kms_key_name
  format        = var.format
  mode          = var.mode
  docker_config {
    immutable_tags = var.format == "DOCKER" ? true : false
  }
  lifecycle {
    ignore_changes = [labels]
  }
   depends_on = [ google_project_iam_binding.network_binding4 ]
}
data "google_project" "service_project3" {
  project_id = var.project_id
}
resource "google_project_iam_binding" "network_binding4" {
  count   = 1
  lifecycle {
    ignore_changes = [ members ]
  }
  project = var.project_id
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    "serviceAccount:service-${data.google_project.service_project3.number}@gcp-sa-artifactregistry.iam.gserviceaccount.com",
  ]
}

