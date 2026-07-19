vms = {
  vm-dev = {
    machine_type = "e2-micro"
    zone         = "us-central1-a"
    tags         = ["dev", "web"]
    subnet = "subnet-0"
  }

  vm-qa = {
    machine_type = "e2-small"
    zone         = "us-east4-b"
    tags         = ["qa", "web"]
    subnet = "subnet-1"
  }

  vm-prod = {
    machine_type = "e2-medium"
    zone         = "us-east4-c"
    tags         = ["prod", "web"]
    subnet = "subnet-2"
  }
}


subnets = {
    subnet-1 = {
        region = "us-central1"
        ip_cidr_range = "10.1.0.0/16"
    }

    subnet-2 = {
        region = "us-east4"
        ip_cidr_range = "10.2.0.0/16"
    }

    subnet-3 = {
        region = "us-east4"
        ip_cidr_range = "10.0.0.0/16"
    }
}