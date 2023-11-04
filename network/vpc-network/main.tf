resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc"
  auto_create_subnetworks = true # true로 설정하면 기본 서브넷을 모든 리전에 자동으로 생성
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "my-subnet"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = "10.0.0.0/16"
}

resource "google_compute_instance" "this" {
  name         = "my-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    # 서브넷을 지정하려면 access_config 필요
    access_config {

    }
  }
}
