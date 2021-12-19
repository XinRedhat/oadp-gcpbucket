provider "google" {
  project     = var.project
}

locals {
  sa_name = "${var.bucket}-sa"
  role_name = "${var.bucket}_role"
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
  account_id = local.sa_name
  display_name = "Velero service account for bucket ${var.bucket}"
}

resource "google_project_iam_custom_role" "velero_role" {
  role_id     = local.role_name
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

resource "google_project_iam_binding" "project" {
  project = var.project
  role    = google_project_iam_custom_role.velero_role.name

  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]
}

resource "google_storage_bucket_iam_member" "concurrent_iam" {
  bucket = var.bucket
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_service_account_key" "sa_key" {
  service_account_id = google_service_account.sa.name
}

resource "local_file" "credentials-velero" {
    content     = base64decode(google_service_account_key.sa_key.private_key)
    filename = "credentials-velero"
}