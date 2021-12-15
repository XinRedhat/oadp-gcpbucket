provider "google" {
  project     = var.project
}

resource "google_storage_bucket" "bucket" {
  name = var.bucket
  location = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 2
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_service_account" "sa" {
  account_id = "${var.bucket}-sa"
  display_name = "Velero service account for bucket ${var.bucket}"
}

# output "sa_name" {
#   value = google_service_account.sa.name
# }

resource "google_project_iam_custom_role" "velero_role" {
  role_id     = "${var.bucket}_role"
  title       = "${var.bucket} Velero Server"
  permissions = ["compute.disks.get", 
                 "compute.disks.create", 
                 "compute.disks.createSnapshot",
                 "compute.snapshots.get",
                 "compute.snapshots.create",
                 "compute.snapshots.useReadOnly",
                 "compute.snapshots.delete",
                 "compute.zones.get"]
}

output "role_name" {
  value = google_project_iam_custom_role.velero_role.name
}


resource "google_project_iam_binding" "project" {
  project = var.project
  role    = google_project_iam_custom_role.velero_role.role_id

  members = [
    "serviceAccount:${google_project_iam_custom_role.velero_role.name}",
  ]
}