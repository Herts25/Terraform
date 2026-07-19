

variable "project_id" {
  type = string
  default = "my-second-project-501115"
}

variable "region" {
  type = string
  default = "us-central1"
}

variable "vpc_name" {
  type = string
  default = "vpc1"
}

variable "subnet_name" {
  type = string
  default = "subnet1"
}

variable "zone_name" {
  type = string
  default = "us-central1-a"
}


variable "cidr" {
  type = string
  default = "10.0.0.0/24"
}