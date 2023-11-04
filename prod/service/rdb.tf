resource "google_compute_network" "this" {
  provider = google
  name     = var.vpc_name
}

resource "google_compute_subnetwork" "pvt_network" {
  name          = local.subnet_name
  ip_cidr_range = "10.0.0.0/16"
  region        = module.const.regions.tokyo.region
  network       = google_compute_network.this.id
}

resource "google_compute_address" "internal_with_subnet_and_address" {
  name         = "my-internal-address"
  subnetwork   = google_compute_subnetwork.pvt_network.id
  address_type = "INTERNAL"
  address      = "10.0.42.42"
  region       = module.const.regions.tokyo.region
}


resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google
  network                 = google_compute_network.pvt_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {
  provider = google-beta

  name             = "private-instance-${random_id.db_name_suffix.hex}"
  region           = "us-central1"
  database_version = "MYSQL_5_7"

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.private_network.id
      enable_private_path_for_google_cloud_services = true
    }
  }
}

provider "google-beta" {
  region = "us-central1"
  zone   = "us-central1-a"
}
