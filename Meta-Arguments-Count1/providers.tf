#provider
provider "google" {
    project  =   var.project_id
    region   =   var.region
}

#terraform settings block
terraform {
  required_version = "~> 1.15.0"
  required_providers {
    google = {
        version = "~> 7.35"
    }
  }
    
  }