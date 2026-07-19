resource "google_service_account" "i27_sa" {
  account_id   = var.service_account_id
  display_name = "Demo SA for VM usage"
   depends_on = [null_resource.delay_sa_ready]
}

resource "null_resource" "delay_sa_ready" {
  provisioner "local-exec" {
   interpreter = ["PowerShell", "-Command"]

    command = <<EOT
      Write-Host "Starting 30 second delay..."
      Start-Sleep -Seconds 30
      Write-Host "30 second delay completed"
    EOT
  }
}

resource "google_compute_instance" "i27_vm_fail" {
  name         = "i27-vm-fail"
  machine_type = "e2-micro"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  service_account {
    email  = "${var.service_account_id}@${var.project_id}.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  tags = ["ssh-tag"]

  #depends_on = [
    #google_service_account.i27_sa,
    #null_resource.delay_sa_ready
  #]

}