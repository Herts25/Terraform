#---------------Count--------------------



#create vpc
#create 2 subnetworks
#use the count metaargument

resource "google_compute_network" "vpc1" {
  name = "vpc-1"
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "subnet-in-vpc1" {
    name = "subnet-${count.index}"
    count = 2
    network = google_compute_network.vpc1.id
    region = var.region
    ip_cidr_range = var.ip_cidr_range[count.index]

}

resource "google_compute_instance" "vms-in-vpc1" {
  name = "vm-${count.index}"
  count = 2
  machine_type = var.machine_type[count.index]

boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
}
zone = var.zone[count.index]
    
     network_interface {
        network = google_compute_network.vpc1.id
        subnetwork = var.subnet[count.index]

     }

}




