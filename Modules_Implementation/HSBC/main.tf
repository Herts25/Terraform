
#I will call the modules
#Calling VPC module
module "vpc" {
  source = "../modules/vpc"
#module variable = local variable
  vpc_name = var.local_vpc_name
}

#Calling the subnet module
module "subnet" {
  source = "../modules/subnet"
  subnet_name = var.local_subnet_name
  region = var.region
  ip_cidr_range = var.ip_cidr_range
  vpc_id = module.vpc.vpc_id
  depends_on = [ module.vpc ]
}

#calling the GCE module
module "GCE" {
  source = "../modules/GCE"
  vm_name = var.vm_name
  zone = var.zone
  machine_type = var.machine_type
  subnet_id = module.subnet.subnet_id
  depends_on = [ module.subnet ]
}