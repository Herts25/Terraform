output "vm-name" {
  description = "name of the vm"
  value = google_compute_instance.vm1.name
}

output "vpc2-ID" {
  description = "ID of the vpc2"
  value = google_compute_network.vpc2.id
}

output "subnet2-ID" {
  description = "ID of the subnet2"
  value = google_compute_subnetwork.subnet2.id
  sensitive = true
}

output "external-IP-of-vm1" {
  description = "this will print the external IP of vm"
  value = google_compute_instance.vm1.network_interface[0].access_config[0].nat_ip
}