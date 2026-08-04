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
  depends_on = [google_project_iam_member.network_binding4]
}
data "google_project" "service_project3" {
  project_id = var.project_id
}

# Additive member, NOT an authoritative google_project_iam_binding.
#
# As a binding this resource REPLACED every member of
# roles/cloudkms.cryptoKeyEncrypterDecrypter across the whole project, so it
# silently revoked the GCS, Cloud SQL, Dataproc, Composer, GKE and BigQuery
# service agents that hold the same role. `lifecycle { ignore_changes = [members] }`
# did not prevent that — it only hid the resulting drift from later plans, which
# is why the damage was invisible. Mirrors the fix already shipped in
# cloud-storage-bucket (google_project_iam_member.network_binding5).
resource "google_project_iam_member" "network_binding4" {
  for_each = toset([
    "serviceAccount:service-${data.google_project.service_project3.number}@gcp-sa-artifactregistry.iam.gserviceaccount.com",
  ])
  project = var.project_id
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = each.value
}

