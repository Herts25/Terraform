resource "google_compute_network" "vpc_1" {
  name = var.vpc_name
  auto_create_subnetworks = false
}

