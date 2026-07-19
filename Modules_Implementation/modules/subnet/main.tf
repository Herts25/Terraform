resource "google_compute_subnetwork" "subnet_1" {
  name =  var.subnet_name
  region = var.region
  ip_cidr_range = var.ip_cidr_range
  network = var.vpc_id
}



