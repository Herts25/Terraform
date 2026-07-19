


terraform {
  backend "gcs" {
    bucket = "tfstate_sample"
    prefix = "Infra"
  }
}