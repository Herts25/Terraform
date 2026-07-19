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

resource "google_compute_instance" "vm1" {
    name = "vm1"
    #zone = "us-central1-a"
    zone = "us-central1-b"
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


  metadata = {
    startup_script = "echo 'hello from telford' > /tmp/output.txt"
  }

  lifecycle {
    ignore_changes = [ metadata ]
    create_before_destroy = true
  }
  
}