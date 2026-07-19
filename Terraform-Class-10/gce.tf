


resource "google_compute_instance" "gce_instance" {
    name = "vm1"
    zone = var.zone_name
    machine_type = "e2-micro"

    boot_disk {
     initialize_params {
     image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {}
  
}
  
}





#-------------------importing--------------------


resource "google_compute_instance" "vm2" {

name = "vm2"
zone = var.zone_name
machine_type = "e2-micro"



  boot_disk {

    initialize_params {
    image = "projects/debian-cloud/global/images/debian-13-trixie-v20260609"
  }

  }

  network_interface {
    access_config {}
    subnetwork  = google_compute_subnetwork.subnet.id
  }

  tags = ["http-server"]

  }