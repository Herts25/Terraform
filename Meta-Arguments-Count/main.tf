#default provider
provider "google" {
    project  =   "project-7c50df6f-4f02-45b5-b8b"
    region   =   "us-central1"
}

#second provider
provider "google" {
    alias = "project_2"
    project  =   "my-second-project-501115"
    region   =   "us-east1"
}



#terraform settings block
terraform {
  required_version = "~> 1.15.0"
  required_providers {
    google = {
        version = "~> 7.35"
    }
  }
    
  }


#vpc3
resource "google_compute_network" "vpc3" {
     name  =   "tf-vpc3"
     provider = google.project_2
     auto_create_subnetworks = false
}

#subnet-3
resource "google_compute_subnetwork" "subnet3"{
    name = "tf-subnet3"
    provider = google.project_2
    description = "this subnet is created via terraform in vpc3"
    ip_cidr_range = "10.1.0.0/24"
    region = "us-east1"
    #implit dependency
    network = google_compute_network.vpc3.id
}

#firewall
resource "google_compute_firewall" "vpc1-allow-ssh" {
     name = "tf-allow-ssh-vpc3"
     provider = google.project_2
     network = google_compute_network.vpc3.id
     
     allow {
        protocol = "tcp"
        ports = [ "22",  "80" ]
     }

     allow {
        protocol = "icmp"
     }

     direction = "INGRESS"
     priority = "1000"
     source_ranges = ["0.0.0.0/0"]
     target_tags = ["http-server-3"]

}

#compute engine instance
#meta-argument-count
resource "google_compute_instance" "vm1" {
    provider = google.project_2
    count = 2
    name = "dev-vm-${count.index}"
    machine_type = "e2-small"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

     zone = "us-east1-c"
     tags = ["http-server-1"]

     network_interface {

        network = google_compute_network.vpc3.id
        subnetwork = google_compute_subnetwork.subnet3.id

     }
 
}