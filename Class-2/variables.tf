#variables



#---------------------string----------------------
variable "machine_type" {
  type        = string
  description = "The machine type for the VM instance"
  #default    = "e2-medium"
}

variable "project_id" {
  type        = string
  description = "The GCP project ID"
  #default    = "project-7c50df6f-4f02-45b5-b8b"
}
variable "region" {
  type        = string
  description = "The GCP region"
  #default    = "us-central1"
}

variable "zone" {
  type        = string
  description = "The GCP zone"
  #default    = "us-central1-a"
}



#-------------------bool--------------------------
variable "enable_startup_script" {
  type        = bool
  description = "to enable the startup script or not"
  #true/false
  #default    =  true
}



#------------------list(string)---------------------
variable "ports" {
  type        = list(string)
  description = "this will open the required ports"
  #default    = ["22", "80"]
  
}



#--------------------number----------------------
variable "http-priority" {
  type = number
  description = "this will give the priority allow/deny"
  default = 900
  
}



#---------------------map(string)----------------------------
variable "machine_types" {
  type = map(string)
  description = "machine types for GCE"
  default = {
    dev = "e2-micro"
    qa  = "e2-small"
    prod = "e2-medium"

  }

}

variable "environment" {
  type = string
  description = "this is very specific to environment"
  #default = "qa"
  
}


#--------------object---------------------
variable "vm_configuration" {
  type = object({
    name = string
    region = string
    zone = string
    tags = list(string)
    https_priority = number
    image = map(string)

  })

  default = {
    name = "object-vm"
    region = "us-central1"
    zone = "us-central1-a"
    tags = ["tag1" ,"tag2"]
    https_priority = 500
    image = {
      "dev" = "n2-standard-2"
      "qa" = "n2-standard-4"
      "prod" = "n2-standard-8"
    }
  }

}

  variable "object_environment"{
   type = string
   description = "this is very specific to environment"
   default = "prod"

  }



#---------list(object)-------------------
variable "vm_list" {
  type = list(object({
    name         = string
    machine_type = string
    zone         = string
    tags         = list(string)
  }))
}


    


