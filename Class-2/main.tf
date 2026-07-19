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


#create static ip address
resource "google_compute_address" "tf_static_ip" {
    name = "vm1-ip"
  
}

#vm
resource "google_compute_instance" "vm1" {
    name = "vm1"
     machine_type = var.machine_types["prod"]


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
        access_config {
        nat_ip = google_compute_address.tf_static_ip.address
        }

     }

   #startup script
   #conditional run based on the variables
   metadata_startup_script = var.enable_startup_script ? file("${path.module}/startup.sh") : null

   #metadata_startup_script = file("${path.module}/startup.sh")


  
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
    machine_type = var.machine_types[var.environment]

  
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

#------------------object---------------------
     #vm
resource "google_compute_instance" "object-vm" {
    name = var.vm_configuration.name
    machine_type = var.vm_configuration.image[var.object_environment]

  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
     

     zone = var.vm_configuration.zone
     tags = var.vm_configuration.tags

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
        ports = var.ports
     }

     allow {
        protocol = "icmp"
     }

     direction = "INGRESS"
     priority = var.vm_configuration.https_priority
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




resource "google_compute_instance" "vm1" {
  name         = var.vm_list[0].name
  machine_type = var.vm_list[0].machine_type
  zone         = var.vm_list[0].zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tf_subnet.id
    access_config {}
  }

  tags = var.vm_list[0].tags
}

resource "google_compute_instance" "vm2" {
  name         = var.vm_list[1].name
  machine_type = var.vm_list[1].machine_type
  zone         = var.vm_list[1].zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.tf_subnet.id
    access_config {}
  }

  tags = var.vm_list[1].tags
}