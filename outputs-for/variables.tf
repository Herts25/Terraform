variable "vm_count" {
description = "this is the list of vms" 
type = number
default = 2
}

variable "vm_name" {
  description = "these are vm names"
  type = string
  default = "app-server"
}

