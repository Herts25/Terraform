variable "project_id" {
  type = string
  description = "this is the project ID"
  #default = "my-second-project-501115"
}

variable "region" {
  type = string
  description = "this is the region"
  #default = "us-central1"
}

variable "ip_cidr_range" {
  type = list(string)
  description = "this is the cidr ranges"
  #default = "10.1.0.0/16"
}

variable "machine_type" {
  type = list(string)
  description = "this is machine type"
  #default = [ "value" ]
}

variable "zone" {
  type = list(string)
  description = "this is zone"
  #default = [ "value" ]
}


variable "subnet" {
    type = list(string)
    description = "this is subnet"
    #default = [ "value" ]
}