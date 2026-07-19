variable "vms" {

    description = "VM configuration"
    type = map(object({
    machine_type = string
    zone         = string
    subnet = string
    tags         = list(string)

  }))
}

variable "subnets"{
  
    description = "creating subntes"
    type = map(object({
      region = string
      ip_cidr_range = string
    }))
  
}