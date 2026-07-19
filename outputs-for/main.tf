resource "google_compute_network" "vpc1" {
  name = "vpc1"
  description = "creating a vpc to check the life cycle meta-argument"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
    name = "subnet1"
    region = "us-central1"
    ip_cidr_range = "10.0.0.0/16"
    network = google_compute_network.vpc1.id
}

resource "google_compute_instance" "vm_list_of_2" {
    count = var.vm_count
    name = "${var.vm_name}-${count.index}"
    zone = "us-central1-1"
    machine_type = "e2-micro"


       boot_disk {
     initialize_params {
     image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet1.id

    access_config {}
  
}
}