terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  version     = "3.5.0"
  credentials = file("../../keys/loans-project-editor-sa.json")
  project     = var.project_id
  region      = var.project_default_region
  zone        = var.project_default_zone
}