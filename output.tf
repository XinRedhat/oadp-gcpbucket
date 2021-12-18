output "bucket_name" {
  value = google_storage_bucket.bucket.name
}

output "service_account" {
  value = google_service_account.sa.account_id
}
