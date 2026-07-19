#variables
variable "machine_type" {
  type        = string
  description = "The machine type for the VM instance"
  default     = "e2-micro"
}

variable "project_id" {
  type        = string
  description = "The GCP project ID"
  default     = "project-7c50df6f-4f02-45b5-b8b"
}
variable "region" {
  type        = string
  description = "The GCP region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "The GCP zone"
  default     = "us-central1-a"
}






#provider
provider "google" {
    project  =   var.project_id
    region   =   var.region
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




#vpc1
resource "google_compute_network" "vpc1" {
     name  =   "tf-vpc1"
     auto_create_subnetworks = false
}

#subnet-1
resource "google_compute_subnetwork" "subnet1"{
    name = "tf-subnet1"
    description = "this subnet is created via terraform in vpc1"
    ip_cidr_range = "10.1.0.0/24"
    region = var.region
    #implit dependency
    network = google_compute_network.vpc1.id
}

#firewall
resource "google_compute_firewall" "vpc1-allow-ssh" {
     name = "tf-allow-ssh-vpc1"
     network = google_compute_network.vpc1.id
     
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
     target_tags = ["http-server-1"]



}

#vm
resource "google_compute_instance" "vm1" {
    name = "vm1"
     machine_type = var.machine_type


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

     zone = var.zone
     tags = ["http-server-1"]

     network_interface {

        network = google_compute_network.vpc1.id
        subnetwork = google_compute_subnetwork.subnet1.id

     }


  
}




#vpc2
resource "google_compute_network" "vpc2" {
     name  =   "tf-vpc2"
     auto_create_subnetworks = false
}

#subnet2
resource "google_compute_subnetwork" "subnet2"{
    name = "tf-subnet2"
    description = "this subnet is created via terraform in vpc2"
    ip_cidr_range = "10.2.0.0/24"
    region = var.region
    #implit dependency
    network = google_compute_network.vpc2.id
}




     #vm
resource "google_compute_instance" "vm2" {
    name = "vm2"
     machine_type = var.machine_type

  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
     

     zone = var.zone
     tags = ["http-server-2"]

     network_interface {

        network = google_compute_network.vpc2.id
        subnetwork = google_compute_subnetwork.subnet2.id
        
     }
}
     #firewall
resource "google_compute_firewall" "vpc2-allow-ssh" {
     name = "tf-allow-ssh-vpc2"
     network = google_compute_network.vpc2.id
     
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
     target_tags = ["http-server-2"]
     



}

#vpc peering vpc1 to vpc2
resource "google_compute_network_peering" "vpc1_to_vpc2" {
    name = "peering-vpc1-to-vpc2"
    network = google_compute_network.vpc1.id
    peer_network = google_compute_network.vpc2.id
}

#vpc peering vpc2 to vpc1
resource "google_compute_network_peering" "vpc2_to_vpc1" {
    name = "peering-vpc2-to-vpc1"
    network = google_compute_network.vpc2.id
    peer_network = google_compute_network.vpc1.id
}