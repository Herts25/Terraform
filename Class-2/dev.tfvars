#key = value


machine_type = "e2-micro"
project_id = "project-7c50df6f-4f02-45b5-b8b"
region = "us-central1"
zone = "us-central1-b"
enable_startup_script = "false"
ports = [ "22", "8080" ]
http_priority = 300
environment = "qa"


#------------object---------------
vm_configuration = {
  name           = "object-vm"
  region         = "us-central1"
  zone           = "us-central1-a"
  tags           = ["tag1", "tag2"]
  https_priority = 400
  image          = {
    "dev"  = "n2-standard-2"
    "qa"   = "n2-standard-4"
    "prod" = "n2-standard-8"
  }
}
object_environment = "qa"
