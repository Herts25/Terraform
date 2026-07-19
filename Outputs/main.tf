resource "google_compute_network" "vpc2" {
  name = "vpc2"
  description = "creating a vpc to check the life cycle meta-argument"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet2" {
    name = "subnet2"
    region = "us-central1"
    ip_cidr_range = "10.0.0.0/16"
    network = google_compute_network.vpc2.id
}

resource "google_compute_instance" "vm1" {
    name = "vm1"
    #zone = "us-central1-b"
    zone = "us-central1-b"
    machine_type = "e2-micro"

      boot_disk {
     initialize_params {
     image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet2.id

    access_config {}

  }

  lifecycle {
    create_before_destroy = true
  }


}