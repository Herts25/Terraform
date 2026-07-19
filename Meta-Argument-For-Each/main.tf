

#---------------for_each(map)---------------

#Example: Create multiple VMs using for_each(map)

#resource "google_compute_instance" "vm" {
  #for_each     = var.vms          # loops over each key in the map
  #name         = each.key         # "vm-dev", "vm-qa", "vm-prod"
  #machine_type = each.value.machine_type
  #zone         = each.value.zone
  #tags         = each.value.tags

  #boot_disk {
    #initialize_params {
     # image = "debian-cloud/debian-12"
   # }
  #}

  #network_interface {
   # network = google_compute_network.vpc1.id
    #access_config {}
  #}
#}

#vpc
resource "google_compute_network" "vpc1" {
 name= "vpc-1"
 auto_create_subnetworks = false
}

#Example: Crate multiple subnets
resource "google_compute_subnetwork" "subnet" {
  for_each = var.subnets
  name = each.key
  region = each.value.region
  ip_cidr_range = each.value.ip_cidr_range
 network = google_compute_network.vpc1.id
}



#-----------for_each set of strings-------------

#Example: create list of vms or list of buckets

resource "google_compute_instance" "webserver" {
  for_each     = toset(var.vm_names)         
  name         = each.key       #each.key or eack.value
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  

  boot_disk {
     initialize_params {
     image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet["subnet-1"].id
    access_config {}
 }
}

variable "vm_names" {
 description = "GCE instance names"
 type = list(string)
 default = [ "webserver-1", "webserver-2" ]
}
