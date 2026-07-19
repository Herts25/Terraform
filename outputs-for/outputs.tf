
#-------list---------
output "all-vm-names" {
  description = "list of all vm names"
  value = [for instance in google_compute_instance.vm_list_of_2 : instance.name]
}


#-----------map-----------
output "all-vm-IDs" {
  description = "map of the vm to vm IDs"
  value = {for instance in google_compute_instance.vm_list_of_2 : instance.name => instance.id}
}


#----------complex map-----------
output "all-details-of-vms" {
  description = "this will print the below mentioned all details of vms"
  value = {
    for instance in google_compute_instance.vm_list_of_2 : instance.name => {
         id = instance.id
         machine_type = instance.machine_type
         zone = instance.zone
         external_ip = instance.network_interface[0].access_config[0].nat_ip
     }
}
}