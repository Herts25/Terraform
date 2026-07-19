#provider
provider "google" {
    project  =   "my-second-project-501115"
    region   =   "us-central1"
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