resource "google_storage_bucket" "delta_lake" {
  name                     = "jinyoung-son-data-delta-lake"
  location                 = local.location
  force_destroy            = true
  public_access_prevention = "enforced"
}

resource "google_storage_bucket" "service_backend" {
  name                     = "jinyoung-son-service-storage"
  location                 = local.location
  force_destroy            = true
  public_access_prevention = "enforced"
}

