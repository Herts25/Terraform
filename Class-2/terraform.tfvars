#key = value


machine_type = "e2_micro" #string
project_id = "project-7c50df6f-4f02-45b5-b8b" #string
region = "us-central1" #string
zone = "us-central1-a" #string
enable_startup_script = "true" #bool
ports = [ "22", "8080" ] #list(string)
environment = "prod"


#------------object---------------
vm_configuration = {
  name           = "object-vm"
  region         = "us-central1"
  zone           = "us-central1-a"
  tags           = ["tag1", "tag2"]
  https_priority = 600
  image          = {
    "dev"  = "n2-standard-2"
    "qa"   = "n2-standard-4"
    "prod" = "n2-standard-8"
  }
  object_environment = "prod"
}




#----------lits(object)-------------
vm_list = [
  
    {
      name         = "listvm1"
      machine_type = "e2-medium"
      zone         = "us-central1-a"
      tags         = ["tag3", "tag4"]
  }

]