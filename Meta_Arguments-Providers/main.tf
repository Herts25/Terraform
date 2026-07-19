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
    region = "us-central1"
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

#compute engine instance
resource "google_compute_instance" "vm1" {
    name = "vm1"
     machine_type = "e2-small"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

     zone = "us-central1-c"
     tags = ["http-server-1"]

     network_interface {

        network = google_compute_network.vpc1.id
        subnetwork = google_compute_subnetwork.subnet1.id

     }
 
}

#vpc2
resource "google_compute_network" "vpc2" {
     name  =   "tf-vpc2"
     provider = google.project_2
     auto_create_subnetworks = false
}

#subnet-2
resource "google_compute_subnetwork" "subnet2"{
    name = "tf-subnet2"
    provider = google.project_2
    description = "this subnet is created via terraform in vpc2"
    ip_cidr_range = "10.1.0.0/24"
    region = "us-east1"
    #implit dependency
    network = google_compute_network.vpc2.id
}

#firewall
resource "google_compute_firewall" "vpc2-allow-ssh" {
     name = "tf-allow-ssh-vpc2"
     provider = google.project_2
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
     target_tags = ["http-server-1"]

}

#compute engine instance
resource "google_compute_instance" "vm2" {
    name = "vm2"
    provider = google.project_2
    machine_type = "e2-micro"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

     zone = "us-east1-b"
     tags = ["http-server-2"]

     network_interface {

        network = google_compute_network.vpc2.id
        subnetwork = google_compute_subnetwork.subnet2.id

     }

  
}